import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';
import 'src/common/service/notification_service.dart';
import 'src/common/widgets/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService()
    ..requestPermisson()
    ..generateToken()
    ..notificationSettings();


  runApp(const App());
}
