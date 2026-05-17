import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:premises/main_imports.dart';

class CustomInterceptors extends Interceptor {
  final Dio dio;
  final SharedPreferencesUtils _sharedPreferencesUtils;
  final int maxRetries;
  final Duration initialBackoff;

  static Completer<String?>? _refreshCompleter;
  static String? _latestAccessToken;
  static DateTime? _lastRefreshTime;

  CustomInterceptors({
    required this.dio,
    this.maxRetries = 1,
    this.initialBackoff = const Duration(seconds: 1),
  }) : _sharedPreferencesUtils = SharedPreferencesUtils();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
      options.extra['retryCount'] = 0;
      if (kDebugMode) {
        _logRequest(options);
      }
      if (options.data is Map<dynamic, dynamic>) {
        options.data = _handleNullValues(options.data as Map<dynamic, dynamic>);
        //CustomLogger.printAll(jsonEncode(options.data));
      } else if (options.data is FormData) {
        options.data = _handleFormData(options.data as FormData);
        //_printFormData(options.data as FormData);
      }
      return super.onRequest(options, handler);
    } catch (e) {
      CustomLogger.logPrint('REQUEST EXCEPTION: $e');
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (kDebugMode) {
        _logResponse(response);
      }
      return super.onResponse(response, handler);
    } catch (e) {
      CustomLogger.logPrint('RESPONSE EXCEPTION: $e');
      return handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (kDebugMode) {
        _logError(err);
      }
      if (_shouldRefreshToken(err)) {
        if (err.requestOptions.extra['retried'] == true) {
          return handler.next(err);
        }
        err.requestOptions.extra['retried'] = true;
        return _handleTokenRefresh(err, handler);
      }
      if (_shouldRetry(err)) {
        return _retry(err, handler);
      }
      return super.onError(err, handler);
    } catch (e) {
      CustomLogger.logPrint('ERROR EXCEPTION: $e');
      return handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.error != null && err.error is SocketException);
  }

  Future<void> _retry(DioException err, ErrorInterceptorHandler handler) async {
    RequestOptions requestOptions = err.requestOptions;
    int retryCount = requestOptions.extra['retryCount'] ?? 0;

    if (retryCount < maxRetries) {
      retryCount++;
      requestOptions.extra['retryCount'] = retryCount;

      CustomLogger.logPrint(
        'RETRYING REQUEST (Attempt $retryCount of $maxRetries)',
      );

      // Implement exponential backoff
      final backoffDuration = initialBackoff * (2 << (retryCount - 1));
      await Future.delayed(backoffDuration);

      try {
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        return onError(e, handler);
      }
    } else {
      CustomLogger.logPrint('MAX RETRIES REACHED');
      return handler.next(err);
    }
  }

  bool _shouldRefreshToken(DioException err) {
    final message = err.response?.data?['message']?.toString().toLowerCase();

    return err.response?.statusCode == 401 &&
        (message == 'jwt expired' ||
            message == 'invalid signature' ||
            message == 'unauthorized' ||
            err.response?.statusMessage?.toLowerCase() == 'unauthorized') &&
        !err.requestOptions.uri.toString().contains(Apis.userLogin);
  }

  Future<String?> _refreshTokenSafely() async {
    if (_latestAccessToken != null &&
        _lastRefreshTime != null &&
        DateTime.now().difference(_lastRefreshTime!).inSeconds < 5) {
      return _latestAccessToken;
    }

    if (_refreshCompleter != null) {
      return await _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String?>();

    try {
      final token = await _refreshToken();

      _latestAccessToken = token;
      _lastRefreshTime = DateTime.now();

      _refreshCompleter!.complete(token);

      return token;
    } catch (e) {
      _refreshCompleter!.complete(null);
      return null;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _handleTokenRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final newAccessToken = await _refreshTokenSafely();

    if (newAccessToken != null && newAccessToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $newAccessToken';

      err.requestOptions.headers = {
        ...err.requestOptions.headers,
        'Authorization': 'Bearer $newAccessToken',
      };

      await Future.delayed(const Duration(milliseconds: 100));

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.next(e);
      } catch (e) {
        CustomLogger.logPrint("XXXX REFRESH UNKNOWN => $e");
      }
    } else {
      await _sharedPreferencesUtils.clearSharedPref();
    }

    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _sharedPreferencesUtils.getRefreshToken();
      if (refreshToken == null) return null;

      final currentAccessToken = await _sharedPreferencesUtils.getAuthToken();

      final refreshDio = Dio(
        BaseOptions(headers: {'content-type': 'application/json'}),
      );

      final response = await refreshDio.post(
        Environment.baseUrl + Apis.userLogin,
        data: {
          'strategy': 'refresh',
          'accessToken': currentAccessToken,
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = UserLoginApiModel.fromJson(response.data);

        await _sharedPreferencesUtils.setAuthToken(
          loginResponse.accessToken ?? '',
        );

        if (loginResponse.refreshToken != null) {
          await _sharedPreferencesUtils.setRefreshToken(
            loginResponse.refreshToken!,
          );
        }

        return loginResponse.accessToken;
      }
    } on DioException catch (e) {
      CustomLogger.logPrint("XXXX TOKEN STATUS => ${e.response?.statusCode}");
      CustomLogger.logPrint("XXXX TOKEN DATA => ${e.response?.data}");
      CustomLogger.logPrint("XXXX TOKEN REQUEST => ${e.requestOptions.data}");
      CustomLogger.logPrint("XXXX TOKEN URL => ${e.requestOptions.uri}");
    } catch (e) {
      CustomLogger.logPrint("XXXX TOKEN UNKNOWN => $e");
    }

    return null;
  }

  void _logRequest(RequestOptions options) {
    CustomLogger.logPrint('REQUEST =>:');
    CustomLogger.printKV('URL', options.uri);
    CustomLogger.printKV('METHOD', options.method);
    CustomLogger.printKV('HEADERS', options.headers);
    CustomLogger.logPrint('REQUEST BODY:');
    _logRequestBody(options.data);
  }

  void _logRequestBody(dynamic data) {
    if (data is Map<dynamic, dynamic>) {
      CustomLogger.printAll(jsonEncode(_handleNullValues(data)));
    } else if (data is FormData) {
      _printFormData(data);
    } else if (data != null) {
      CustomLogger.printAll(data.toString());
    }
  }

  void _logResponse(Response response) {
    final responseTime = _calculateResponseTime(response.requestOptions);
    CustomLogger.logPrint('RESPONSE =>:');
    CustomLogger.printKV('URL', response.requestOptions.uri);
    CustomLogger.printKV(
      'STATUS',
      '${response.statusCode} ${response.statusMessage}',
    );
    CustomLogger.printKV('RESPONSE TIME', '$responseTime ms');
    CustomLogger.printKV(
      'RESPONSE SIZE',
      '${_calculateResponseBodySize(response)} KB',
    );
    CustomLogger.logPrint('RESPONSE BODY:');
    CustomLogger.printAll(jsonEncode(response.data));
  }

  void _logError(DioException err) {
    final responseTime = _calculateResponseTime(err.requestOptions);
    CustomLogger.logPrint('ERROR =>:');
    CustomLogger.printKV('URL', err.requestOptions.uri);
    CustomLogger.printKV(
      'STATUS',
      '${err.response?.statusCode} ${err.response?.statusMessage}',
    );
    CustomLogger.printKV('RESPONSE TIME', '$responseTime ms');
    CustomLogger.logPrint('ERROR BODY:');
    CustomLogger.printAll(jsonEncode(err.response?.data));
  }

  int _calculateResponseTime(RequestOptions options) {
    final startTime = options.extra['startTime'] as int;
    return DateTime.now().millisecondsSinceEpoch - startTime;
  }

  void _printFormData(FormData formData) {
    CustomLogger.logPrint('FormData:');
    for (var field in formData.fields) {
      CustomLogger.printKV(' - ${field.key}', field.value);
    }
    for (var file in formData.files) {
      CustomLogger.printKV(
        ' - ${file.key}',
        '${file.value.filename} (${file.value.contentType})',
      );
    }
  }

  double _calculateResponseBodySize(Response response) {
    final responseBody = response.data;
    int sizeInBytes;

    if (responseBody is String) {
      sizeInBytes = responseBody.length;
    } else if (responseBody is List) {
      sizeInBytes = responseBody.length;
    } else if (responseBody is Map) {
      sizeInBytes = jsonEncode(responseBody).length;
    } else {
      sizeInBytes = responseBody.toString().length;
    }

    return sizeInBytes / 1024;
  }

  Map<String, dynamic> _handleNullValues(Map<dynamic, dynamic> data) {
    return data.map((key, value) {
      if (value == '' || value == null || value == 'null' || value == "") {
        return MapEntry(key.toString(), null);
      }
      if (value is Map) {
        return MapEntry(key.toString(), _handleNullValues(value));
      }
      return MapEntry(key.toString(), value);
    });
  }

  FormData _handleFormData(FormData formData) {
    FormData newFormData = FormData();
    for (var field in formData.fields) {
      if (field.value == '' || field.value == "" || field.value == 'null') {
        // Skip empty string values
        continue;
      }
      newFormData.fields.add(MapEntry(field.key, field.value));
    }
    // Copy files as they are
    for (var file in formData.files) {
      newFormData.files.add(file);
    }
    return newFormData;
  }
}
