import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/utils/logger.dart';
import 'package:premises/features/dashboard/listener.dart';

abstract class BaseStateClass<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver
    implements UpdateLowNetworkConnectivity {
  bool isDeviceConnected = true;
  bool isAlertSet = false;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late BaseProvider baseProvider;

  late final InternetConnection _internetConnection;
  late final Connectivity _connectivity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _internetConnection = InternetConnection();
    _connectivity = Connectivity();
    baseProvider = Provider.of<BaseProvider>(context, listen: false);
    baseProvider.setUpdateConnectivityListener(this);
    baseProvider.resetDownloadTestData();
    // baseProvider.runSpeedTest();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    // Check initial connectivity status
    await _checkInitialConnectivity();
    _listenToInternetConnectionChanges();
  }

  Future<void> _checkInitialConnectivity() async {
    // try {
    //   isDeviceConnected = await _internetConnection.hasInternetAccess;
    //   _updateConnectionStatus(isDeviceConnected, source: '_checkConnectivity initial');
    // } catch (e) {
    //   debugPrint('Error checking internet connection: $e');
    //   _updateConnectionStatus(false, source: '_checkConnectivity exceptions');
    // }
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      //CustomLogger.logPrint('connectivityResult.first ${connectivityResult.first}');
      if (connectivityResult.first == ConnectivityResult.none) {
        isDeviceConnected = await _internetConnection.hasInternetAccess;
      } else {
        isDeviceConnected = true;
      }
      //CustomLogger.logPrint('_checkInitialConnectivity() $isDeviceConnected');
      _updateConnectionStatus(isDeviceConnected,
          source: '_checkInitialConnectivity');
    } catch (e) {
      debugPrint('Error checking internet connection: $e');
      _updateConnectionStatus(false, source: 'Exception');
    }
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
      if (result != ConnectivityResult.none) {
        baseProvider.resetDownloadTestData();
        // baseProvider.runSpeedTest();
      }
    });
  }

  void _updateConnectionStatus(bool isConnected, {required String source}) {
    isDeviceConnected = isConnected;
    baseProvider.updateConnectionStatus(isDeviceConnected,
        source: 'Base State Class');
    connectivityChanged(isDeviceConnected, source);
    CustomLogger.logPrint(
        '$source: Device is ${isConnected ? 'connected' : 'disconnected'}');
  }

  void connectivityChanged(bool isDeviceConnected, String source);

  void isConnectedToLowNetwork(bool isLowNetwork);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      case AppLifecycleState.hidden:
        onHidden();
        break;
    }
  }

  void onResumed() {
    // App is visible and running in the foreground
    //_checkConnectivity();
    CustomLogger.logPrint('onResumed');
  }

  void onInactive() {
    // App is in an inactive state (e.g., during a phone call)
    CustomLogger.logPrint('onInactive');
  }

  void onPaused() {
    // App is not visible but still running in the background
    CustomLogger.logPrint('onPaused');
  }

  void onDetached() {
    // App is suspended and not in memory (iOS only)
    CustomLogger.logPrint('onDetached');
  }

  void onHidden() {
    // App is hidden but still running (Android only)
    CustomLogger.logPrint('onHidden');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void updateLowNetwork(bool isLowNetwork) {
    isConnectedToLowNetwork(isLowNetwork);
  }
}
