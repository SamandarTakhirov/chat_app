import 'package:chat_application_with_firebase/src/common/service/auth_service.dart';
import 'package:chat_application_with_firebase/src/features/pages/main_page_controller.dart';
import 'package:flutter/material.dart';

import '../../../data/user_repository.dart';
import '../login/login_page.dart';
import '../widgets/my_textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  late IUserRepository repository;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    repository = const UserRepository();
    super.initState();
  }

  void onPressed() async {
    bool success = await AuthService.registration(
      emailController.text,
      passwordController.text,
      nameController.text,
    );
    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPageController(),
        ),
        (r) => false,
      );
    }
  }

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
                "Please register your account...",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF246BFD),
                ),
              ),
            ),
            MyTextField(
              controller: nameController,
              hintText: "Name",
              isObscureText: false,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
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
              onPressed: onPressed,
              child: const Text(
                "Sign Up",
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
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                });
              },
              child: const Text(
                "Already have a account?",
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
