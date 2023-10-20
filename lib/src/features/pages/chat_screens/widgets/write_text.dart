import 'package:flutter/material.dart';

class WriteText extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final void Function(String text) onChanged;

  const WriteText({
    this.suffixIcon,
    required this.onChanged,
    required this.textEditingController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        autofocus: true,
        onChanged: onChanged,
        controller: textEditingController,
        textInputAction: TextInputAction.newline,
        cursorColor: const Color(0xFF20A090),
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          focusColor: const Color(0xFF246BFD),
          hintText: "Message",
          hintStyle: const TextStyle(
            color: Color(0xFFAEAEB2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF246BFD),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFAEAEB2),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),

          ),
        ),
      ),
    );
  }
}
