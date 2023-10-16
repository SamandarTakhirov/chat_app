import 'package:flutter/material.dart';

import 'account_photo.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int messageTime;
  final int messageCount;
  final void Function() onTap;

  const MyListTile({
    required this.onTap,
    required this.title,
    required this.messageCount,
    required this.messageTime,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      focusColor: Colors.red,
      leading: const AccountPhoto(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            messageTime == 0 ? "Just now": "$messageTime min ago",
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF797C7B),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.red,
            minRadius: 13,
            maxRadius: 13,
            child: Text(
              "$messageCount",
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
