import 'package:flutter/material.dart';

class CustomButtonSheets extends StatefulWidget {
  final  void Function() camera;
  final void Function() gallery;

  const CustomButtonSheets({
    required this.camera,
    required this.gallery,
    super.key,
  });

  @override
  State<CustomButtonSheets> createState() => _CustomButtonSheetsState();
}

class _CustomButtonSheetsState extends State<CustomButtonSheets> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: size.height * 0.2,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF246BFD),
              fixedSize: const Size(80, 80),
              shape: const StadiumBorder(),
            ),
            onPressed: widget.camera,
            child: const Image(
              width: 50,
              height: 50,
              color: Colors.white,
              image: AssetImage("assets/images/ic_camera.png"),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF246BFD),
              fixedSize: const Size(80, 80),
              shape: const StadiumBorder(),
            ),
            onPressed:  widget.gallery,
            child: const Image(
              width: 50,
              height: 50,
              color: Colors.white,
              image: AssetImage("assets/images/ic_gallery.png"),
            ),
          ),
        ],
      ),
    );
  }
}
