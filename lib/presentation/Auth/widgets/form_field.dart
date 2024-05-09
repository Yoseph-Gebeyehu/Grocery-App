import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscure;
  final String hintText;
  final Function? function;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefix;

  const CustomFormField({
    super.key,
    required this.controller,
    this.obscure,
    required this.hintText,
    this.function,
    required this.keyboardType,
    this.validator,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return TextFormField(
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validator!(value),
      controller: controller,
      obscureText: hintText == 'Password' ? obscure! : false,
      style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge!.color,
        fontSize: deviceSize.width * 0.036,
      ),
      cursorWidth: 1.5,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: deviceSize.width * 0.03,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        prefixIcon: prefix!,
        // filled: true,
        // fillColor: const Color.fromARGB(255, 239, 228, 203),
        // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: hintText == 'Password'
            ? IconButton(
                icon: Icon(
                  obscure! ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFFE67F1E),
                  size: 15,
                ),
                onPressed: () {
                  function!();
                },
              )
            : null,
        enabledBorder: inputBorder(const Color.fromARGB(255, 216, 213, 213)),
        focusedBorder: inputBorder(const Color(0xFFFEC54B)),
        focusedErrorBorder: inputBorder(Colors.red),
        errorBorder: inputBorder(Colors.red),
      ),
    );
  }

// color: Color(0xFFFEC54B),
  OutlineInputBorder inputBorder(Color colors) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: colors,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(11),
    );
  }
}
