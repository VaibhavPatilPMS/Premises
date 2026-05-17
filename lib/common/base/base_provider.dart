import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:premises/features/dashboard/listener.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../utils/utils.dart';

class BaseProvider extends ChangeNotifier {
  bool _isNetworkConnected = true;
  UserLocationDetails? userLocationDetails;
  UpdateLowNetworkConnectivity? updateLowNetworkConnectivityListener;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late final InternetConnection _internetConnection;
  late final Connectivity _connectivity;
  final Dio _dio = Dio();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechInitialized = false;
  final Map<String, bool> _speechListeningState = {};
  final Map<String, String> _speechBaseText = {};
  String? _activeSpeechFieldId;

  bool _isTestingSpeed = false;
  double _downloadProgress = 0;
  double _uploadProgress = 0;
  double _downloadSpeed = 0;
  double _uploadSpeed = 0;
  String _status = 'Press the button to start the speed test';

  bool get isTestingSpeed => _isTestingSpeed;

  double get downloadProgress => _downloadProgress;

  double get uploadProgress => _uploadProgress;

  double get downloadSpeed => _downloadSpeed;

  double get uploadSpeed => _uploadSpeed;

  String get status => _status;

  bool isSpeechListening(String fieldId) =>
      _speechListeningState[fieldId] ?? false;

  BaseProvider({bool? isNetworkConnected}) {
    _internetConnection = InternetConnection();
    _connectivity = Connectivity();
    _initConnectivity();
  }

  setUpdateConnectivityListener(UpdateLowNetworkConnectivity listener) {
    updateLowNetworkConnectivityListener = listener;
  }

  bool get isNetworkConnected => _isNetworkConnected;

  Future<void> _initConnectivity() async {
    await _checkInitialConnectivity();
    _listenToInternetConnectionChanges();
  }

  Future<void> _checkInitialConnectivity() async {
    // try {
    //   _isNetworkConnected = await InternetConnection().hasInternetAccess;
    //   CustomLogger.logPrint('_checkInitialConnectivity() $_isNetworkConnected');
    //   //final isConnected = await InternetConnectionChecker.instance.hasConnection;
    //   updateConnectionStatus(_isNetworkConnected,
    //       source: '_checkInitialConnectivity');
    // } catch (e) {
    //   debugPrint('Error checking internet connection: $e');
    //   updateConnectionStatus(false, source: 'Exception');
    // }
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.first == ConnectivityResult.none) {
        _isNetworkConnected = await _internetConnection.hasInternetAccess;
      } else {
        _isNetworkConnected = true;
      }
      //CustomLogger.logPrint('_checkInitialConnectivity() $_isNetworkConnected');
      updateConnectionStatus(
        _isNetworkConnected,
        source: '_checkInitialConnectivity',
      );
    } catch (e) {
      debugPrint('Error checking internet connection: $e');
      updateConnectionStatus(false, source: 'Exception');
    }
  }

  void _listenToInternetConnectionChanges() {
    // _internetConnectionSubscription = InternetConnection().onStatusChange.listen((InternetStatus status) {
    //   CustomLogger.logPrint('status onStatusChange ${status}');
    //   _updateConnectionStatus(source: 'onStatusChange',status==InternetStatus.connected ? true : false);
    // });
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      // Received changes in available connectivity types!
      updateConnectionStatus(
        source: 'onConnectivityChanged',
        result.first == ConnectivityResult.none ? false : true,
      );
    });
  }

  void updateConnectionStatus(bool isConnected, {required String source}) {
    // if (_isNetworkConnected != isConnected) {
    _isNetworkConnected = isConnected;
    notifyListeners();
    //CustomLogger.logPrint('Base Provider $source: Device is ${isConnected ? 'connected' : 'disconnected'}');
    //}
    //}
  }

  Future<bool> _ensureSpeechInitialized() async {
    if (_speechInitialized) {
      return true;
    }

    _speechInitialized = await _speechToText.initialize(
      onStatus: (status) {
        if ((status == 'notListening' || status == 'done') &&
            _activeSpeechFieldId != null) {
          _speechListeningState[_activeSpeechFieldId!] = false;
          _activeSpeechFieldId = null;
          notifyListeners();
        }
      },
      onError: (_) {
        if (_activeSpeechFieldId != null) {
          _speechListeningState[_activeSpeechFieldId!] = false;
          _activeSpeechFieldId = null;
          notifyListeners();
        }
      },
    );
    return _speechInitialized;
  }

  Future<void> toggleSpeechToText({
    required String fieldId,
    required TextEditingController controller,
    void Function(String value)? onChanged,
    required bool enabled,
    required bool readOnly,
  }) async {
    if (!enabled || readOnly) {
      return;
    }

    if (isSpeechListening(fieldId)) {
      await _speechToText.stop();
      _speechListeningState[fieldId] = false;
      if (_activeSpeechFieldId == fieldId) {
        _activeSpeechFieldId = null;
      }
      notifyListeners();
      return;
    }

    final initialized = await _ensureSpeechInitialized();
    if (!initialized) {
      return;
    }

    if (_activeSpeechFieldId != null && _activeSpeechFieldId != fieldId) {
      _speechListeningState[_activeSpeechFieldId!] = false;
    }
    _activeSpeechFieldId = fieldId;
    _speechBaseText[fieldId] = controller.text.trim();

    final started = await _speechToText.listen(
      // pauseFor: const Duration(minutes: 3),
      // listenFor: const Duration(minutes: 3),
      // listenOptions: stt.SpeechListenOptions(
      //   listenMode: stt.ListenMode.dictation,
      //   partialResults: true,
      // ),
      onResult: (result) {
        final recognizedText = result.recognizedWords.trim();
        if (recognizedText.isEmpty || _activeSpeechFieldId != fieldId) {
          return;
        }
        final baseText = _speechBaseText[fieldId] ?? '';
        final combinedText = baseText.isEmpty
            ? recognizedText
            : '$baseText ${recognizedText.trim()}';
        controller.value = TextEditingValue(
          text: combinedText,
          selection: TextSelection.collapsed(offset: combinedText.length),
        );
        onChanged?.call(combinedText);
      },
    );

    _speechListeningState[fieldId] = started ?? _speechToText.isListening;
    notifyListeners();
  }

  void clearSpeechField(String fieldId) {
    final wasListening = _speechListeningState[fieldId] ?? false;
    _speechListeningState.remove(fieldId);
    _speechBaseText.remove(fieldId);
    if (_activeSpeechFieldId == fieldId) {
      _activeSpeechFieldId = null;
      _speechToText.stop();
    }
    if (wasListening) {
      notifyListeners();
    }
  }

  Future<void> getLocationDetails() async {
    userLocationDetails = await LocationUtils().getLocationDetails();
    if (userLocationDetails != null) {
      notifyListeners();
    }
  }

  void resetDownloadTestData() {
    _isTestingSpeed = false;
    _downloadProgress = 0;
    _uploadProgress = 0;
    _downloadSpeed = 0;
    _uploadSpeed = 0;
    _status = 'Press the button to start the speed test';
    //notifyListeners();
  }

  Future<void> runSpeedTest() async {
    _isTestingSpeed = true;
    _downloadProgress = 0;
    _uploadProgress = 0;
    _downloadSpeed = 0;
    _uploadSpeed = 0;
    //notifyListeners();

    await _testDownloadSpeed();
    await _testUploadSpeed();

    _isTestingSpeed = false;
    _status = 'Speed test completed';
    notifyListeners();
  }

  Future<void> _testDownloadSpeed() async {
    _status = 'Testing download speed...';
    //notifyListeners();

    try {
      final int testDuration = 10; // Test duration in seconds
      const payloadSizeInMB = 15.0; // 15 MB payload
      final String testUrl = 'https://link.testfile.org/15MB';
      num totalBytes = 0;
      final stopwatch = Stopwatch()..start();

      while (stopwatch.elapsedMilliseconds < testDuration * 1000) {
        final response = await _dio.get(
          testUrl,
          options: Options(
            responseType: ResponseType.stream,
            contentType: Headers.jsonContentType,
          ),
        );

        await for (final chunk in response.data.stream) {
          if (chunk.length != null) {
            totalBytes += chunk.length;
          }
        }
      }

      stopwatch.stop();
      final durationInSeconds = stopwatch.elapsedMilliseconds / 1000;
      _downloadSpeed =
          (payloadSizeInMB * 8) / durationInSeconds; // Convert MB to Mb
      setLowNetworkSpeed();
    } catch (e) {
      _status = 'Error during download test: $e';
    }
    notifyListeners();
  }

  Future<void> _testUploadSpeed() async {
    _status = 'Testing upload speed...';
    //notifyListeners();

    try {
      final int testDuration = 10; // Test duration in seconds
      final String testUrl = 'https://httpbin.org/post';
      final List<int> testData = List.filled(100000, 0);
      int totalBytesSent = 0;
      final stopwatch = Stopwatch()..start();

      while (stopwatch.elapsedMilliseconds < testDuration * 1000) {
        await _dio.post(
          testUrl,
          data: testData,
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {Headers.contentLengthHeader: testData.length.toString()},
          ),
        );
        totalBytesSent += testData.length;
      }

      stopwatch.stop();
      final elapsedSeconds = stopwatch.elapsedMilliseconds / 1000;
      final bitsSent = totalBytesSent * 8;
      _uploadSpeed = (bitsSent / elapsedSeconds) / 10000; // Mbps
      setLowNetworkSpeed();
    } catch (e) {
      _status = 'Error during upload test: $e';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _speechToText.stop();
    _connectivitySubscription?.cancel(); // Cancel if it exists
    super.dispose();
  }

  setLowNetworkSpeed() {
    CustomLogger.logPrint(
      '_downloadSpeed $_downloadSpeed _uploadSpeed $_uploadSpeed',
    );
    if ((_downloadSpeed < 3 && _downloadSpeed > 0) ||
        (_uploadSpeed < 3 && _uploadSpeed > 0)) {
      updateLowNetworkConnectivityListener?.updateLowNetwork(true);
    } else {
      updateLowNetworkConnectivityListener?.updateLowNetwork(false);
    }
    notifyListeners();
  }
}
