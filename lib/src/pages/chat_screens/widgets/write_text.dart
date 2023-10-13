import 'package:flutter/material.dart';

class WriteText extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget? suffixIcon;

  const WriteText({
    this.suffixIcon,
    required this.textEditingController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: textEditingController,
      textInputAction: TextInputAction.newline,
      cursorColor: const Color(0xFF20A090),
      decoration:  InputDecoration(
        suffixIcon: suffixIcon,
        focusColor: const Color(0xFF246BFD),
        hintText: "Write your message",
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF246BFD),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
