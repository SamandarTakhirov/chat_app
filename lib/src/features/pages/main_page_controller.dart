
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all_chats/all_accounts.dart';
import 'home/home_page.dart';
import 'profile/profile_page.dart';
import 'widgets/bottom_images.dart';

class MainPageController extends StatefulWidget {
  const MainPageController({Key? key}) : super(key: key);

  @override
  State<MainPageController> createState() => _MainPageControllerState();
}

class _MainPageControllerState extends State<MainPageController> {
  int pageIndex = 0;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void pageChange(int value) {
    pageController.jumpToPage(value);
    setState(() {
      pageIndex = value;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: pageChange,
        children: const [
          AllAccount(),
          HomePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF6F6F6),
        currentIndex: pageIndex,
        selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF037EE5)),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onTap: pageChange,
        fixedColor: const Color(0xFF007AFF),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled,
              size: 28,
              color: Color(0xA6545458),
            ),
            label: "Contacts",
            activeIcon: Icon(
              CupertinoIcons.profile_circled,
              size: 28,
              color: Color(0xFF007AFF),
            ),
          ),
          BottomNavigationBarItem(
            icon: BottomImages(image: "assets/images/ic_chat.png"),
            label: "Chats",
            activeIcon: BottomImages(
              image: "assets/images/ic_chat.png",
              isActive: true,
            ),
          ),
          BottomNavigationBarItem(
            icon: BottomImages(
              image: "assets/images/ic_settings.png",
              width: 40,
              height: 32,
            ),
            label: "Profile",
            activeIcon: BottomImages(
              image: "assets/images/ic_settings.png",
              width: 40,
              height: 32,
              isActive: true,
            ),
          ),
        ],
      ),
    );
  }
}
