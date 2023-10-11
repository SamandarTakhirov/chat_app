import 'package:flutter/material.dart';

class AccountPhoto extends StatelessWidget {
  const AccountPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      maxRadius: 24,
      minRadius: 24,
      backgroundImage: AssetImage("assets/images/profile.png"),
    );
  }
}
