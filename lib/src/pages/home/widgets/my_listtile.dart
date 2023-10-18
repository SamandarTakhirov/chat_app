import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int? messageTime;
  final int? messageCount;
  final Widget widget;
  final void Function() onTap;

  const MyListTile({
    required this.widget,
    required this.onTap,
    required this.title,
    this.messageCount,
    this.messageTime,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      focusColor: Colors.red,
      leading: widget,
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
          messageTime != null
              ? Text(
                  messageTime == 0 ? "Just now" : "$messageTime:00",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF797C7B),
                  ),
                )
              : const SizedBox.shrink(),
          messageCount != null
              ? CircleAvatar(
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
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
