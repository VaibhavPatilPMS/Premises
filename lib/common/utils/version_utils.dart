import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionDetails {
  static Future<String?> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      return packageInfo.version;
    } on PlatformException {
      return null;
    }
  }

  static Future<String?> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      return packageInfo.packageName;
    } on PlatformException {
      return null;
    }
  }

  static Future<String?> getAppInstalledName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      return packageInfo.appName;
    } on PlatformException {
      return null;
    }
  }

  static Future<bool?> checkFreemiumSupportedOrNot(
      bool isFreemiumFlagCheck) async {
    String? packageName = await getPackageName();
    try {
      if (packageName == null) return false;

      return (packageName == 'app.vast.vast_safety_app' ||
              packageName == 'app.vast.vast-safety-app') &&
          isFreemiumFlagCheck;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool?> checkMixPanelSupportedOrNot(
      bool isAnalyticsEnabled) async {
    String? packageName = await getPackageName();
    try {
      if (packageName == null) return false;

      return (packageName == 'app.vast.vast_safety_app' ||
              packageName == 'app.vast.vast-safety-app') &&
          isAnalyticsEnabled;
    } on PlatformException {
      return false;
    }
  }
}
