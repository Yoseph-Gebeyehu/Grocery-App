import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xFFE67F1E),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      dividerColor: const Color(0xFFF5F5F5),
      shadowColor: Colors.black26,
      cardColor: const Color(0xFFEEEEEE),
      dividerTheme: const DividerThemeData(
        color: Color.fromARGB(255, 197, 196, 196),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: const Color(0xFFE67F1E),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: const Color(0xFF2E2E2E),
      shadowColor: Colors.white24,
      cardColor: const Color(0xFF2C2C2C),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF4D4D4D),
      ),
    );
  }
}
