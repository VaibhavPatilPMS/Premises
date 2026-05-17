import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
// import 'package:premises/common/utils/logger.dart';

class PermissionUtils {
  Future<bool?> handleStoragePermission(BuildContext? context) async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;

      if (android.version.sdkInt < 33) {
        PermissionStatus? permission;
        permission = await Permission.storage.status;

        if (permission == PermissionStatus.granted) {
          return true;
        }

        return false;
      } else {
        PermissionStatus? permission;
        permission = await Permission.photos.status;

        if (permission == PermissionStatus.granted) {
          return true;
        }

        return false;
      }
    } else if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> handleNotificationPermission(BuildContext? context) async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        return true;
      } else {
        PermissionStatus? permission;
        permission = await Permission.notification.status;
        //CustomLogger.logPrint('permission Status ${permission}');

        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          if (permission == PermissionStatus.denied) {
            permission = await Permission.notification.request();
            //CustomLogger.logPrint('permission Status ${permission}');
            if (permission == PermissionStatus.denied) {
              _showNotificationPermissionDialog(context);
              return false;
            } else if (permission == PermissionStatus.permanentlyDenied) {
              _showNotificationPermissionDialog(context);
              return false;
            }
            return false;
          } else if (permission == PermissionStatus.permanentlyDenied) {
            _showNotificationPermissionDialog(context);
            return false;
          } else {
            return false;
          }
        }
      }
    } else if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> handleMicrophonePermission(BuildContext? context) async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        return true;
      } else {
        PermissionStatus? permission;
        permission = await Permission.microphone.status;
        //CustomLogger.logPrint('permission Status ${permission}');

        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          if (permission == PermissionStatus.denied) {
            permission = await Permission.microphone.request();
            //CustomLogger.logPrint('permission Status ${permission}');
            if (permission == PermissionStatus.denied) {
              return false;
            } else if (permission == PermissionStatus.permanentlyDenied) {
              ;
              return false;
            }
            return false;
          } else if (permission == PermissionStatus.permanentlyDenied) {
            return false;
          } else {
            return false;
          }
        }
      }
    } else if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> _showStoragePermissionDialog(BuildContext? context) {
  //   return showDialog(
  //     context: context!,
  //     builder: (context) {
  //       return CommonAlertDialog(
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //           openAppSettings();
  //         },
  //         dialogButtonName: AppStrings().open_settings,
  //         dialogMessage: AppStrings().storage_permission,
  //         dialogTitle: AppStrings().storage_permission_title,
  //       );
  //     },
  //   );
  // }

  Future<void> _showNotificationPermissionDialog(BuildContext? context) {
    return showDialog(
      context: context!,
      builder: (context) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(context).pop();
            openAppSettings();
          },
          dialogButtonName: AppStrings().open_settings,
          dialogMessage: AppStrings().notification_permission,
          dialogTitle: AppStrings().notification_permission_title,
        );
      },
    );
  }
}

class DeviceUtils {
  static Future<String?> getDeviceDetails() async {
    if (AppData().uniqueDeviceId != null) {
      return AppData().uniqueDeviceId;
    } else {
      try {
        return await getUniqueDeviceId();
      } on PlatformException {
        return null;
      }
    }
  }

  static Future<String?> getUniqueDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      // For Android
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Unique ID for Android
    } else if (Platform.isIOS) {
      // For iOS
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // Unique ID for iOS
    }
    return null; // Unsupported platform
  }
}
