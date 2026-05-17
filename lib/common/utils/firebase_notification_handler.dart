import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:premises/common/utils/logger.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   description: 'This channel is used for important notifications.',
//   // description
//   importance: Importance.high,
//   enableVibration: true,
//   playSound: true,
//   showBadge: true,
//   enableLights: true,
// );

void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.input?.isNotEmpty ?? false) {}
}

class FirebaseNotifications {
  //In App Notification Sound
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationAppLaunchDetails? notificationAppLaunchDetails;

  final BehaviorSubject<ReceivedNotification>
  didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();
  final BehaviorSubject<String?> selectNotificationSubject =
  BehaviorSubject<String?>();

  bool catchOnce = false;

  Future<void> showSoundUriNotification(RemoteMessage message,) async {
    final x = RawResourceAndroidNotificationSound("incident_report_scheduler");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'scheduled_notification_incident', 'scheduled_notification_incident',
        channelDescription:
        'Play Custom Sound to show Incident Report Notifications',
        sound: x,
        enableLights: true,
        enableVibration: true,
        playSound: true,
        importance: Importance.high,
        autoCancel: false,
        priority: Priority.max,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: "incident_report_scheduler.caf",
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        '${message.notification!.title}',
        '${message.notification!.body}',
        platformChannelSpecifics,
        payload: '${message.notification!.title}');
  }

  Future<void> initialize() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await _isAndroidPermissionGranted();
      await _requestPermissions();
      await _createNotificationChannels();

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      notificationAppLaunchDetails = await flutterLocalNotificationsPlugin
          .getNotificationAppLaunchDetails();

      AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('app_icon');

      DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings(
        defaultPresentSound: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        requestAlertPermission: true,
        requestSoundPermission: true,
      );

      var platformChannelSpecifics = InitializationSettings(
          android: androidInitializationSettings,
          iOS: initializationSettingsDarwin);

      await flutterLocalNotificationsPlugin.initialize(
        platformChannelSpecifics,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              selectNotificationSubject.add(notificationResponse.payload);
              break;
            case NotificationResponseType.selectedNotificationAction:
              break;
          }
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );

      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
        //CustomLogger.printAll('notification...');
      }

      // FirebaseMessaging.instance.getToken().then((token) {
      //   return token;
      // });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // CustomLogger.logPrint(
        //     'request body notifications event ${message.data['event']}');
        // CustomLogger.logPrint(
        //     'request body notifications channel id ${message.notification?.android?.channelId}');
        if ((message.data['event'] != null &&
            message.data['event'].toString() ==
                'scheduled_notification_incident') ||
            (message.notification?.android?.channelId ==
                'scheduled_notification_incident')) {
          //CustomLogger.logPrint('in background onMessage event matched');
          FirebaseNotifications().showSoundUriNotification(message);
        } else {
          _showPlainNotification(message);
        }
      });

      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) async {
        if (message != null) {
          //CustomLogger.printAll('notification...$message');
        }
      });

      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        catchOnce = false;
        //CustomLogger.logPrint('message onMessageOpenedApp${message.data}');
      });
    } catch (e) {
      //CustomLogger.logPrint('firebase initialise exceptions ${e.toString()}');
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      // final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      //     AndroidFlutterLocalNotificationsPlugin>();
    }
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      // final bool granted = await flutterLocalNotificationsPlugin
      //     .resolvePlatformSpecificImplementation<
      //     AndroidFlutterLocalNotificationsPlugin>()
      //     ?.areNotificationsEnabled() ??
      //     false;
    }
  }

  Future<void> _showPlainNotification(RemoteMessage message,) async {
    final receivedNotification = message.notification;
    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings('app_icon');

    DarwinInitializationSettings initializationSettingsDarwin =
    const DarwinInitializationSettings(
        defaultPresentSound: false,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        requestAlertPermission: true,
        requestSoundPermission: true);

    var platformChannelSpecifics = InitializationSettings(
        android: androidInitializationSettings,
        iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(
      platformChannelSpecifics,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationSubject.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('vsa_imp_channel', 'vsa_imp_channel',
        channelDescription: 'For Showing Important notification',
        playSound: true,
        importance: Importance.high,
        autoCancel: false,
        priority: Priority.max,
        enableLights: true,
        ticker: 'ticker',
        enableVibration: true,
        styleInformation: DefaultStyleInformation(true, true));

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    if (receivedNotification?.title != null ||
        receivedNotification?.body != null) {
      await flutterLocalNotificationsPlugin.show(
          message.hashCode,
          '${receivedNotification?.title}',
          '${receivedNotification?.body}',
          notificationDetails,
          payload: 'Default_Sound');
    }
  }

  Future<String?> getFirebaseMessagingToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      CustomLogger.logPrint('firebase token \n$token');
      return token;
    } catch (e) {
      return null;
    }
  }

  int getNotificationId(String event) {
    switch (event) {
      case 'scheduled_notification_incident':
        return Random().nextInt(100);
      default:
        return Random().nextInt(100);
    }
  }

  Future<void> _createNotificationChannels() async {
      AndroidNotificationChannel channelHighImportance = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        // description
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        enableLights: true,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channelHighImportance);

      const AndroidNotificationChannel vsaImpChannel = AndroidNotificationChannel(
        'vsa_imp_channel', // id
        'vsa_imp_channel', // title
        description: 'For Showing Important notification',
        // description
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        enableLights: true,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(vsaImpChannel);

      const AndroidNotificationChannel scheduledNotificationsChannel = AndroidNotificationChannel(
        'scheduled_notification_incident', // id
        'scheduled_notification_incident', // title
        description: 'For Showing Scheduled Notifications',
        // description
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        enableLights: true,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(scheduledNotificationsChannel);
    }
}

class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
