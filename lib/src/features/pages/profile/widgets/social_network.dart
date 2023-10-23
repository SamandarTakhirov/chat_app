import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialNetwork extends StatelessWidget {
  final String url;
  final String icon;
  final String socialName;
  final String accountName;

  const SocialNetwork({
    required this.socialName,
    required this.accountName,
    required this.icon,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // if (!url.startsWith("https://")) {
        //   // url = "https://$url";
        // }
        if (!await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.platformDefault,
        )) {
          throw Exception('Could not launch $url');
        }
      },
      child: Row(
        children: [
          Image(
            width: 40,
            height: 40,
            image: AssetImage(icon),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                socialName,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                accountName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
