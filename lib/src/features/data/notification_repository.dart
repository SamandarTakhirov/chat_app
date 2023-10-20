

import '../../common/service/notification_service.dart';

abstract interface class INotificationRepository {
  final String chatPath;

  const INotificationRepository(this.chatPath);

  Future<void> sendNotification(String body, String token, String title);
}

class NotificationRepository extends INotificationRepository {
   NotificationRepository(super.chatPath) : _serviceNotification = NotificationService();
  final NotificationService _serviceNotification;

  @override
  Future<void> sendNotification(
    String body,
    String token,
    String title,
  ) =>
      _serviceNotification.sendNotification(
        body: body,
        token: token,
        title: title,
      );
}
