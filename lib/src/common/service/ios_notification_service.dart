import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class IosNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("chat App");

    final initializationSettingsIos = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id,
            String? title,
            String? body,
            String? payload,) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIos
    );
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (
            NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId", "channelName", importance: Importance.max,),
      iOS: DarwinNotificationDetails()

    );
  }

  Future showNotification(
      {int id = 1, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

}
