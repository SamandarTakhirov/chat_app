import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final IconData icons;

  const ProfileListTile({
    required this.icons,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        tileColor: Colors.white,
        trailing: Icon(
          icons,
          color: const Color(0xFF246BFD),
        ),
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF246BFD),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
