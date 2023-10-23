import 'package:flutter/cupertino.dart';
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
      child: CircleAvatar(
        maxRadius: size+1,
        minRadius: size+1,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          maxRadius: size,
          minRadius: size,
          backgroundColor: Colors.white,
          child: Icon(
            CupertinoIcons.person,
            color: const Color(0xFF246BFD),
            size: size*0.9,
          ),
        ),
      ),
    );
  }
}
