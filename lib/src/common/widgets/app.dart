import 'package:flutter/material.dart';
import '../../pages/auth/login/login_page.dart';
import '../../pages/home/home_page.dart';
import '../service/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ChatApp",
      theme: ThemeData(
        useMaterial3: true,
      ),
      // ignore: unnecessary_null_comparison
      home: AuthService.user == null ? const LoginPage() : const HomePage(),
    );
  }
}
