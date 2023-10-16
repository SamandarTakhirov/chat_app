import 'package:chat_application_with_firebase/src/common/service/auth_service.dart';
import 'package:chat_application_with_firebase/src/pages/auth/login/login_page.dart';
import 'package:chat_application_with_firebase/src/pages/auth/registration/registration_page.dart';
import 'package:flutter/material.dart';

import '../home/widgets/account_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: [
                        const AccountPhoto(
                          size: 50,
                        ),
                        Positioned(
                          bottom: -4,
                          right: -4,
                          child: IconButton(
                            style: FilledButton.styleFrom(
                              maximumSize: const Size(40, 40),
                              minimumSize: const Size(40, 40),
                              backgroundColor: const Color(0xFF246BFD),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              size: 25,
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        AuthService.auth.currentUser!.displayName!,
                        style: const TextStyle(
                          color: Color(0xFF246BFD),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xFF246BFD),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton(
                style: FilledButton.styleFrom(
                  maximumSize: const Size(double.infinity, 60),
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: const Color(0xFF246BFD),
                ),
                onPressed: () {
                  AuthService.logOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.logout)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                style: FilledButton.styleFrom(
                  maximumSize: const Size(double.infinity, 60),
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: const Color(0xFF246BFD),
                ),
                onPressed: () {
                  AuthService.deleteAccount();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delete account",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.delete)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
