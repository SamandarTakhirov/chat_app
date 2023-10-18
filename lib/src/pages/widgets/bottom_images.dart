import 'package:flutter/material.dart';

class BottomImages extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final bool? isActive;

  const BottomImages({
    required this.image,
    this.width = 29,
    this.isActive = false,
    this.height = 26,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      color: isActive! ? const Color(0xFF007AFF) : const Color(0xA6545458),
      image: AssetImage(image),
      width: width,
      height: height,
    );
  }
}
