import 'package:flutter/material.dart';
import '../../features/pages/auth/registration/registration_page.dart';
import '../../features/pages/main_page_controller.dart';
import '../service/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatAPP",
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // ignore: unnecessary_null_comparison
      home: (AuthService.auth.currentUser == null)
          ? const RegistrationPage()
          : const MainPageController(),
    );
  }
}
