import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  // Format input as: 12 345 678
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to max 8 digits
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 5) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }

    // Maintain cursor position
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
