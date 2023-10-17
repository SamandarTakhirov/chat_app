
import 'package:flutter/material.dart';

import '../../pages/auth/login/login_page.dart';
import '../../pages/main_page_controller.dart';
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
      home: (AuthService.user == null) ? const LoginPage() : const MainPageController(),
    );
  }
}
