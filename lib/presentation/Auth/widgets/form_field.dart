import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  TextEditingController controller;
  bool? obscure;
  String hintText;
  Function? function;

  CustomFormField({
    required this.controller,
    this.obscure,
    required this.hintText,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hintText == 'Password' ? obscure! : false,
      style: const TextStyle(color: Colors.black),
      cursorColor: const Color(0xFFFEC54B),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 239, 228, 203),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: hintText == 'Password'
            ? IconButton(
                icon: Icon(
                  obscure! ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  function!();
                  // setState(() {
                  //   obscure = !obscure;
                  // });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
