import 'package:flutter/material.dart';

class AccountPhoto extends StatelessWidget {
  final void Function()? onTap;
  final double size;
  const AccountPhoto({
    this.size = 24,
    this.onTap,
    super.key,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  CircleAvatar(
        maxRadius: size,
        minRadius: size,
        backgroundImage: const AssetImage("assets/images/profile.png"),
      ),
    );
  }
}
