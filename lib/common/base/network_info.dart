import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  bool get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  //final InternetConnection _internetConnection = InternetConnection();
  //late StreamSubscription<InternetStatus> _internetConnectionSubscription;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool _isNetworkConnected = false;
  late final InternetConnection _internetConnection;
  late final Connectivity _connectivity;

  NetworkInfoImpl({bool? isConnected}) {
    if (isConnected != null) {
      _isNetworkConnected = isConnected;
    }
    _internetConnection = InternetConnection();
    _connectivity = Connectivity();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    // Initial check
    await _checkInitialConnectivity();
    _listenToInternetConnectionChanges();
  }

  void _listenToInternetConnectionChanges() {
    // _internetConnectionSubscription = InternetConnection().onStatusChange.listen((InternetStatus status) {
    //   CustomLogger.logPrint('status onStatusChange ${status}');
    //   _updateConnectionStatus(source: 'onStatusChange',status==InternetStatus.connected ? true : false);
    // });
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!
      _updateConnectionStatus(
          source: 'onConnectivityChanged',
          result.first == ConnectivityResult.none ? false : true);
    });
  }

  Future<void> _checkInitialConnectivity() async {
    // try {
    //   final status = await _internetConnection.hasInternetAccess;
    //   _updateConnectionStatus(status,source: '_checkInitialConnectivity');
    // } catch (e) {
    //   CustomLogger.logPrint('Error checking internet connection: $e');
    //   _updateConnectionStatus(false,source: 'Exception'); // Assume disconnected on error
    // }
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.first == ConnectivityResult.none) {
        _isNetworkConnected = await _internetConnection.hasInternetAccess;
      } else {
        _isNetworkConnected = true;
      }
      //CustomLogger.logPrint('_checkInitialConnectivity() $_isNetworkConnected');
      _updateConnectionStatus(_isNetworkConnected,
          source: '_checkInitialConnectivity');
    } catch (e) {
      _updateConnectionStatus(false, source: 'Exception');
    }
  }

  // void _updateConnectionStatus(bool isConnected) {
  //   _isNetworkConnected = isConnected;
  //   //CustomLogger.logPrint('Network status changed under network info: ${_isNetworkConnected == true ? 'Connected' : 'Disconnected'}');
  // }

  void _updateConnectionStatus(bool isConnected, {required String source}) {
    // if (_isNetworkConnected != isConnected) {
    _isNetworkConnected = isConnected;
    //debugPrint("Connection Status Changed: $_isNetworkConnected"); // Helpful for debugging
    //CustomLogger.logPrint('Base Provider $source: Device is ${isConnected ? 'connected' : 'disconnected'}');
    //}
  }

  @override
  bool get isConnected => _isNetworkConnected;

  void dispose() {
    _connectivitySubscription?.cancel(); // Cancel if it exists
  }
}
