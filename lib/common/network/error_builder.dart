import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:provider/provider.dart';
import 'package:premises/app_config.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/features/user_management/provider.dart';
import 'package:premises/common/base/response_model.dart';
import 'package:premises/common/resources/resources.dart';

class ErrorBuilder<T> {
  final context = navigatorKey.currentState!.overlay!.context;

  ResponseModel<T> getErrorResponseModel(dynamic obj) {
    try {
      if (obj is ArgumentError) {
        return _buildErrorResponse(message: 'Argument Error');
      } else if (obj is DioException) {
        return _handleDioError(obj);
      }
      return _buildErrorResponse(
        message: AppStrings().error_while_processing_request,
      );
    } catch (e) {
      CustomLogger.logPrint('Exception in ErrorBuilder: $e');
      return _buildErrorResponse(message: 'Unknown Error');
    }
  }

  ResponseModel<T> _handleDioError(DioException error) {
    try {
      String? message;

      message = DioErrorMessages.getUserFriendlyErrorMessage(error);

      if (_isUnauthorized(error, message)) {
        _handleUnauthorized();
      }

      _logError(error);

      return _buildErrorResponse(
        message: message,
        statusCode: error.response?.statusCode,
        dioException: error,
      );
    } catch (e) {
      return _buildErrorResponse(
        message: AppStrings().error_while_processing_request,
        statusCode: error.response?.statusCode,
        dioException: error,
      );
    }
  }

  /// Determines if the error is Unauthorized (401)
  bool _isUnauthorized(DioException error, String? message) {
    return (error.response?.statusCode == 401) &&
        (error.response?.statusMessage == 'Unauthorized' ||
            message == 'Invalid signature' ||
            message == 'Unauthorized');
  }

  void _handleUnauthorized() {
    Provider.of<UserManagementProvider>(
      context,
      listen: false,
    ).userLogout(context, isForceLogout: true);
  }

  void _logError(DioException error) {
    if (Environment.IS_CRASHLYTICS_ALLOW == 'YES') {
      try {
        FirebaseCrashlytics.instance.recordError(
          error,
          error.stackTrace,
          reason: 'API Error',
          fatal: true,
          printDetails: false,
          information: [
            'URL: ${error.requestOptions.uri}',
            'Method: ${error.requestOptions.method}',
            'Status Code: ${error.response?.statusCode}',
            'Status Message: ${error.response?.statusMessage}',
            'Error: ${error.error}',
            'Response: ${error.response?.data}',
          ],
        );
      } catch (e) {
        CustomLogger.logPrint('Error logging to Crashlytics: $e');
      }
    }
  }

  ResponseModel<T> _buildErrorResponse({
    String? message,
    int? statusCode,
    DioException? dioException,
  }) {
    return ResponseModel<T>(
      isSuccess: false,
      message: message,
      statusCode: statusCode,
      dioException: dioException,
      data: null,
    );
  }
}

class DioErrorMessages {
  static String getUserFriendlyErrorMessage(DioException? exception) {
    if (exception?.type == null) {
      return exception?.response?.statusCode == 502
          ? AppStrings().bad_gateway
          : AppStrings().error_while_processing_request;
    }
    try {
      switch (exception?.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timed out. Please check your internet — it seems slow.";
        case DioExceptionType.receiveTimeout:
          return "Server is taking too long to respond. Your internet connection seems slow.";
        case DioExceptionType.sendTimeout:
          return "Request timed out. Please check your internet — it seems slow.";
        case DioExceptionType.badResponse:
          return exception?.response?.data['message']?.toString() ??
              exception?.message ??
              "We encountered an error processing your request. Please try again later.";
        case DioExceptionType.cancel:
          return "Request was cancelled.";

        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return _getNetworkErrorMessage(exception);

        default:
          return exception?.response?.data['message']?.toString() ??
              AppStrings().error_while_processing_request;
      }
    } catch (e) {
      return AppStrings().error_while_processing_request;
    }
  }

  static String _getNetworkErrorMessage(DioException? error) {
    return (error?.message?.contains('SocketException') ?? false) ||
            (error?.message?.contains('Failed host lookup') ?? false) ||
            (error?.message?.contains('The connection errored') ?? false)
        ? "No internet connection. Please check your network and try again. "
              "If you're experiencing slow internet speed, try refreshing the page or switching to a more stable network." // Using a generic message instead of AppStrings().no_internet_connection
        : error?.response?.data['message']?.toString() ??
              error?.message ??
              "No internet connection. Please check your network and try again. "
                  "If you're experiencing slow internet speed, try refreshing the page or switching to a more stable network.";
  }
}
