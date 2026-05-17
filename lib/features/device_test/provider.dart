import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/models/models.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DeviceTestProvider extends BaseProvider {
  ConnectivityResult? result;
  String? connectionType;
  int megaByte = 1024 * 1024 * 1024;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  bool? isLoading;
  @override
  UserLocationDetails? userLocationDetails;
  PermissionStatusModel? permissionStatusModel;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final Dio _dio = Dio();

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

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  var deviceData = <String, dynamic>{};

  DeviceTestProvider() : super() {
    isLoading = true;
  }

  void setHealthCheckData() {}

  void initPlatformState() async {
    // setLoading(true);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    dynamic data;

    try {
      if (Platform.isAndroid) {
        const platform = MethodChannel('vsa_safety_app/device_test');
        final dynamic result = await platform
            .invokeMethod('memory_details'); //sending data from flutter here
        data = result;
        double? totalSpace;
        double? totalFreeSpace;
        double? totalUsedSpace;
        double? totalPhysicalMemory;
        double? totalFreePhysicalMemory;
        if (data != null) {
          totalSpace =
              double.parse(data['totalSpace'].toString()).toPrecision(2);
          totalFreeSpace =
              double.parse(data['totalFreeSpace'].toString()).toPrecision(2);
          totalUsedSpace = (totalSpace - totalFreeSpace).toPrecision(2);
          totalPhysicalMemory =
              double.parse(data['totalPhysicalMemory'].toString())
                  .toPrecision(2);
          totalFreePhysicalMemory =
              double.parse(data['totalFreePhysicalMemory'].toString())
                  .toPrecision(2);

          deviceData = _readAndroidBuildData(
              await deviceInfoPlugin.androidInfo,
              packageInfo,
              totalSpace,
              totalFreeSpace,
              totalUsedSpace,
              totalPhysicalMemory,
              totalFreePhysicalMemory);
        } else {
          // totalSpace = await StorageInfo.getStorageTotalSpaceInGB;
          // totalFreeSpace = await StorageInfo.getStorageFreeSpaceInGB;
          // totalUsedSpace = await StorageInfo.getStorageUsedSpaceInGB;
          // totalPhysicalMemory =
          //     (SysInfo.getTotalPhysicalMemory() ~/ megaByte).roundToDouble();
          // totalFreePhysicalMemory =
          //     (SysInfo.getFreePhysicalMemory() ~/ (1024 * 1024))
          //         .roundToDouble();

          totalSpace = 0.0;
          totalFreeSpace = 0.0;
          totalUsedSpace = 0.0;
          totalPhysicalMemory = 0.0;
          totalFreePhysicalMemory = 0.0;

          deviceData = _readAndroidBuildData(
              await deviceInfoPlugin.androidInfo,
              packageInfo,
              totalSpace,
              totalFreeSpace,
              totalUsedSpace,
              totalPhysicalMemory,
              totalFreePhysicalMemory);
        }
      }
    } on PlatformException {
      //data = "Android is not responding please check the code";
      data = null;
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    setLoading(false);
    notifyListeners();
  }

  Map<String, dynamic> _readAndroidBuildData(
      AndroidDeviceInfo build,
      PackageInfo packageInfo,
      totalSpace,
      totalFreeSpace,
      totalUsedSpace,
      totalPhysicalMemory,
      totalFreePhysicalMemory) {
    return <String, dynamic>{
      'Processor': build.board.toBeginningOfSentence(),
      'Brand': build.brand.toBeginningOfSentence(),
      'Device': build.device.toBeginningOfSentence(),
      'Manufacturer': build.manufacturer.toBeginningOfSentence(),
      'Model': build.model.toBeginningOfSentence(),
      'isPhysicalDevice': build.isPhysicalDevice,
      //'identifier': build.id,
      'Android OS Version': build.version.release,
      'App Version': packageInfo.version,
      'Connection Type': connectionType,
      'Total Storage Space in GB': totalSpace,
      'Total Free Space in GB': totalFreeSpace,
      'Total Used Space in GB': totalUsedSpace,
      'Total physical memory in GB': totalPhysicalMemory,
      'Free physical memory in GB': totalFreePhysicalMemory,
      // 'Total virtual memory in GB': SysInfo.getTotalVirtualMemory() ~/ megaByte,
      // 'Free virtual memory in GB':
      //     SysInfo.getFreeVirtualMemory() ~/ (1024 * 1024),
      // 'Virtual memory size in GB': SysInfo.getVirtualMemorySize() ~/ megaByte,
    };
  }

  Future<UserLocationDetails?> checkLocationPermission(
      {BuildContext? context}) async {
    setLoading(true);
    notifyListeners();
    userLocationDetails = await LocationUtils().getLocationDetails();
    if (userLocationDetails != null) {
      setLoading(false);
      notifyListeners();
      return userLocationDetails;
    } else {
      setLoading(false);
      notifyListeners();
      return null;
    }
  }

  checkAppPermissions(BuildContext? context) async {
    setLoading(true);
    //notifyListeners();
    try {
      bool? isLocationPermission = false;
      bool? isStorage =
          await PermissionUtils().handleStoragePermission(context) ?? false;
      LocationPermission permission =
          await _geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        isLocationPermission = false;
      } else {
        isLocationPermission = true;
      }
      bool? serviceEnabled =
          await _geolocatorPlatform.isLocationServiceEnabled();

      permissionStatusModel = PermissionStatusModel(
        isLocation: isLocationPermission,
        isLocationServiceOn: serviceEnabled,
        isStorage: isStorage,
      );
      notifyListeners();
    } catch (e) {
      permissionStatusModel = null;
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
    setLoading(false);
    notifyListeners();
  }

  Future<void> runSpeedTest() async {
    _isTestingSpeed = true;
    _downloadProgress = 0;
    _uploadProgress = 0;
    _downloadSpeed = 0;
    _uploadSpeed = 0;
    notifyListeners();

    await _testDownloadSpeed();
    await _testUploadSpeed();

    _isTestingSpeed = false;
    _status = 'Speed test completed';
    notifyListeners();
  }

  Future<void> _testDownloadSpeed() async {
    _status = 'Testing download speed...';
    notifyListeners();

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
              contentType: Headers.jsonContentType),
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
    } catch (e) {
      _status = 'Error during download test: $e';
    }
    notifyListeners();
  }

  Future<void> _testUploadSpeed() async {
    _status = 'Testing upload speed...';
    notifyListeners();

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
            headers: {
              Headers.contentLengthHeader: testData.length.toString(),
            },
          ),
        );
        totalBytesSent += testData.length;
      }

      stopwatch.stop();
      final elapsedSeconds = stopwatch.elapsedMilliseconds / 1000;
      final bitsSent = totalBytesSent * 8;
      _uploadSpeed = (bitsSent / elapsedSeconds) / 10000; // Mbps
    } catch (e) {
      _status = 'Error during upload test: $e';
    }
    notifyListeners();
  }
}
