import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all_chats/all_accounts.dart';
import 'home/home_page.dart';
import 'profile/profile_page.dart';

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
        onTap: pageChange,
        fixedColor: const Color(0xFF007AFF),
        type: BottomNavigationBarType.fixed,
        items: const [
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Contacts",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "Chats",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
