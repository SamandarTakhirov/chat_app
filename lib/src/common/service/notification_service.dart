import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _onBackgroundNotification(RemoteMessage message) async {
  // print(
  //   'Handing a background message : ${message.messageId} / ${message.notification?.body} / ${message.notification?.title} / ${message.notification?.titleLocKey}',
  // );
}

class NotificationService {
  String? fcmToken;

  static final _LNS = FlutterLocalNotificationsPlugin();
  static final _messaging = FirebaseMessaging.instance;

  Future<void> requestPermisson() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> initialize() => Future.wait<void>([
        requestPermisson(),
        generateToken(),
        notificationSettings(),
      ]);

  Future<void> generateToken() async {
    await _messaging.getToken().then(
      (value) => fcmToken = value,
      onError: (Object? e, StackTrace stack) async {
        await generateToken();
      },
    );

    print('------------------------------------------------------------------------');
    print(fcmToken);
    print(
        '------------------------------------------------------------------------');
  }

  Future<void> notificationSettings() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) =>
          print('FCM notification settings - $payload'),
    );

    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _LNS.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        print('On notification clicked (id): ${details.id}');
        print('On notification clicked (actionId): ${details.actionId}');
        print('On notification clicked (input): ${details.input}');
        print(
            'On notification clicked (notificationResponseType): ${details.notificationResponseType}');
        print('On notification clicked (payload): ${details.payload}');

        /// TODO(Miracle): set router to push some route
      },
    );

    FirebaseMessaging.onMessage.listen((message) async {
      print('----------------- onMessage ------------------------');
      print(
        'onMessage : ${message.notification?.title} | ${message.notification?.body} | ${message.data}',
      );

      await _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('----------------- onMessageOpenedApp ------------------------');
      print(
        'onMessage : ${message.notification?.title} | ${message.notification?.body} | ${message.data}',
      );

      await _showNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(_onBackgroundNotification);
  }
}

Future<void> _showNotification(RemoteMessage message) async {
  if (message.notification != null) {
    const androidPlatformSpecifics = AndroidNotificationDetails(
      'firebase_messaging_with_friend_flutter_bro_1',
      'firebase_messaging_with_friend_flutter_bro',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      fullScreenIntent: true,
      // sound: RawResourceAndroidNotificationSound('notification_sound'), // you need to add android -> app -> src -> main -> res -> "raw" new folder
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    final id = Random().nextInt((pow(2, 31) - 1).toInt());

    await NotificationService._LNS.show(
      id,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }
}
