import 'package:chat_application_with_firebase/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

import '../../pages/auth/login/login_page.dart';
import '../service/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // ignore: unnecessary_null_comparison
      home: (AuthService.user!=null)? const HomePage() : const LoginPage(),
    );
  }
}
