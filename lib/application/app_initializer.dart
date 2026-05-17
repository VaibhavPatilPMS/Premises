import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:premises/app_config.dart';
import 'package:premises/common/utils/utils.dart';

class AppInitializer {
  static Future<void> initializeApp({required int appEnvironments}) async {
    // Parallel execution of independent tasks
    await Future.wait([
      _loadEnvironment(appEnvironments: appEnvironments),
      _initializeFirebase(),
      _requestPermissions(),
      //_initializeNotificationChannels(),
    ]);
  }

  static Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      await FirebaseNotifications().initialize();
    } catch (e) {
      CustomLogger.logPrint('Firebase initialization error: ${e.toString()}');
    }
  }

  static Future<void> _requestPermissions() async {
    final plugin = DeviceInfoPlugin();
    final permissions = <Permission>[
      Permission.notification,
    ];

    if (Platform.isAndroid) {
      final android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        permissions.add(Permission.storage);
      } else {
        permissions.add(Permission.photos);
      }
    } else if (Platform.isIOS) {
      permissions.add(Permission.storage);
    }

    await permissions.request();
  }

  // static Future<void> _initializeNotificationChannels() async {
  //   if (Platform.isAndroid) {
  //     await FlutterNotificationChannel().registerNotificationChannel(
  //       description: 'For Showing Important notification',
  //       id: 'vsa_imp_channel',
  //       importance: NotificationImportance.IMPORTANCE_HIGH,
  //       name: 'vsa_imp_channel',
  //       allowBubbles: true,
  //       enableSound: true,
  //       enableVibration: true,
  //       showBadge: true,
  //       visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  //     );
  //
  //     await FlutterNotificationChannel().registerNotificationChannel(
  //       description: 'For Showing Scheduled Notifications',
  //       id: 'scheduled_notification_incident',
  //       importance: NotificationImportance.IMPORTANCE_HIGH,
  //       name: 'scheduled_notification_incident',
  //       allowBubbles: true,
  //       enableSound: true,
  //       enableVibration: true,
  //       showBadge: true,
  //       visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  //     );
  //   }
  // }

  static Future<void> _loadEnvironment({required int appEnvironments}) async {
    await dotenv.load(fileName: Environment.getEnvironment(appEnvironments)!);
  }

  static Future<bool> fetchRemoteConfig(
      {required bool isNetworkConnected}) async {
    bool isFreemium = true;
    //bool isAnalyticsEnabled = false;
    if (isNetworkConnected) {
      final remoteConfig = FirebaseRemoteConfig.instance;

      try {
        await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 25),
          minimumFetchInterval: const Duration(seconds: 10),
        ));
        await remoteConfig.fetchAndActivate();
        isFreemium = remoteConfig.getBool('is_freemium');
        //isAnalyticsEnabled = remoteConfig.getBool('isAnalyticsEnabled');
      } catch (e) {
        CustomLogger.logPrint(
            'Firebase remote config exception: ${e.toString()}');
      }
    } else {
      isFreemium = false;
      //isAnalyticsEnabled = false;
    }
    return isFreemium;
    //return (isFreemium, isAnalyticsEnabled);
  }
}
