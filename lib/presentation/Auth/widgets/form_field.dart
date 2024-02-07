import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscure;
  final String hintText;
  final Function? function;
  final TextInputType? keyboardType;

  const CustomFormField({
    super.key,
    required this.controller,
    this.obscure,
    required this.hintText,
    this.function,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.this_field_is_required;
        }
        return null;
      },
      controller: controller,
      obscureText: hintText == 'Password' ? obscure! : false,
      style: TextStyle(color: Theme.of(context).textTheme.titleLarge!.color),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // filled: true,
        // fillColor: const Color.fromARGB(255, 239, 228, 203),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: hintText == 'Password'
            ? IconButton(
                icon: Icon(
                  obscure! ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFFE67F1E),
                ),
                onPressed: () {
                  function!();
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFFEC54B),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFFEC54B),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
