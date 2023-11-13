import 'package:chat_application_with_firebase/src/features/pages/main_page_controller.dart';
import 'package:flutter/material.dart';

import '../../../../common/service/auth_service.dart';
import '../registration/registration_page.dart';
import '../widgets/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  void onPressed(BuildContext context) async {
    bool success = await AuthService.login(
      emailController.text,
      passwordController.text,
    );
    if (success) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPageController()),
          (route) => false);
    }
  }

  void openRegistrationPage() => setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegistrationPage(),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              child: Text(
                "Welcome to back Chat App",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF246BFD),
                ),
              ),
            ),
            MyTextField(
              controller: emailController,
              hintText: "Enter email address",
              isObscureText: false,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              isObscureText: false,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: Size(size.width * 0.9, 50),
                maximumSize: Size(size.width * 0.9, 50),
                backgroundColor: const Color(0xFF246BFD),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              onPressed: () => onPressed(context),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              onPressed: openRegistrationPage,
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Color(0xFF246BFD),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
