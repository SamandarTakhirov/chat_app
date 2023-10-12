import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;

  final bool isObscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  const MyTextField({
    required this.hintText,
    required this.errorText,
    required this.controller,
    required this.isObscureText,
    required this.textInputType,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFF246BFD),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.transparent,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.transparent,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
          hintText: hintText,
          errorText: errorText,
          border: const OutlineInputBorder(
            gapPadding: 50,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        textInputAction: textInputAction,
        keyboardType: textInputType,
      ),
    );
  }
}
