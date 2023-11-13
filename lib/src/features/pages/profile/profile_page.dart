import 'package:chat_application_with_firebase/src/common/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/login/login_page.dart';
import '../auth/registration/registration_page.dart';
import '../home/widgets/account_photo.dart';
import 'widgets/profile_list_tile.dart';
import 'widgets/social_network.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    closeIconColor: Colors.white,
                                    showCloseIcon: true,
                                    backgroundColor: Color(0xFF037EE5),
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection:
                                        DismissDirection.startToEnd,
                                    content: Text("Will update soon..."),
                                    duration: Duration(seconds: 4), 
                                  ),
                                );
                            },
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthService.auth.currentUser!.displayName!,
                        style: const TextStyle(
                          color: Color(0xFF246BFD),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),Text(
                        AuthService.auth.currentUser!.email!,
                        style: const TextStyle(
                          color: Color(0xFF246BFD),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            closeIconColor: Colors.white,
                            showCloseIcon: true,
                            backgroundColor: Color(0xFF037EE5),
                            behavior: SnackBarBehavior.floating,
                            dismissDirection: DismissDirection.startToEnd,
                            content: Text("Will update soon..."),
                            duration: Duration(seconds: 4),
                          ),
                        );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF246BFD),
                    ),
                  ),
                ],
              ),
            ),
            ProfileListTile(
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      closeIconColor: Colors.white,
                      showCloseIcon: true,
                      backgroundColor: Color(0xFF037EE5),
                      behavior: SnackBarBehavior.floating,
                      dismissDirection: DismissDirection.startToEnd,
                      content: Text("Will update soon..."),
                      duration: Duration(seconds: 4),
                    ),
                  );
              },
              icons: CupertinoIcons.arrow_down_doc,
              text: "Saved Messages",
            ),
            ProfileListTile(
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      closeIconColor: Colors.white,
                      showCloseIcon: true,
                      backgroundColor: Color(0xFF037EE5),
                      behavior: SnackBarBehavior.floating,
                      dismissDirection: DismissDirection.startToEnd,
                      content: Text("Will update soon..."),
                      duration: Duration(seconds: 4),
                    ),
                  );
              },
              icons: Icons.notifications_active_outlined,
              text: "Notification settings",
            ),
            ProfileListTile(
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      closeIconColor: Colors.white,
                      showCloseIcon: true,
                      backgroundColor: Color(0xFF037EE5),
                      behavior: SnackBarBehavior.floating,
                      dismissDirection: DismissDirection.startToEnd,
                      content: Text("Will update soon..."),
                      duration: Duration(seconds: 4),
                    ),
                  );
              },
              icons: CupertinoIcons.globe,
              text: "Language",
            ),
            ProfileListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                AuthService.logOut();
              },
              icons: Icons.logout_outlined,
              text: "Log out",
            ),
            ProfileListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationPage(),
                    ));
                AuthService.deleteAccount();
              },
              icons: CupertinoIcons.delete,
              text: "Delete account",
            ),
            const SizedBox(height: 100),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialNetwork(
                  icon: "assets/images/ic_insta.png",
                  url: "https://www.instagram.com/flutter.bro/",
                  accountName: "flutter.bro",
                  socialName: "Instagram",
                ),
                SocialNetwork(
                  icon: "assets/images/tg_icon.png",
                  url: "https://t.me/flutterbro1",
                  accountName: "FlutterBro",
                  socialName: "Telegram",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
