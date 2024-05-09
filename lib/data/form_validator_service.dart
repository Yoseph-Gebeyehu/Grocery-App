import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/widgets.dart';

class FormValidatorService {
  final BuildContext context;
  FormValidatorService({required this.context});
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is empty';
    }
    if (!EmailUtils.isEmail(value)) {
      return 'Invalid email';
    }
    return null;
  }

  String? validatePasswordForSignin(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is empty';
    }

    // Check for lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain lowercase letter';
    }

    // Check for uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain uppercase letter';
    }

    // Check for symbol
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password must contain symbol';
    }

    // Check for number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain number';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  String? validateConfirmPassword(String value, String password) {
    if (value.isEmpty) {
      return 'Confirm Password is empty';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateText(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName is empty';
    }

    return null;
  }

  // Validator for optional referral code field
  String? validateOptionalField(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    // You can add validation rules for referral code if needed
    // Example: Ensure referral code has a specific format
    // if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
    //   return 'Invalid referral code format';
    // }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone number is empty';
    }

    // Check for valid phone number format (exactly 10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Phone number must be a 10-digit number';
    }

    // Check if the phone number starts with 09,07 or 011
    if (!RegExp(r'^(09|07|011)').hasMatch(value)) {
      return 'Enter a valid phone no.';
    }

    return null;
  }
}
