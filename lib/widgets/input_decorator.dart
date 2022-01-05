import 'package:diary_webapp/constants/constants.dart';
import 'package:flutter/material.dart';

InputDecoration buildInputDecorationOnTeal(
    String label, String hint, IconData icon) {
  return InputDecoration(
    // filled: true,
    // fillColor: const Color(0XFF2acad0),

    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kWhiteColor),
      borderRadius: BorderRadius.circular(4),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kLightTealColor),
      borderRadius: BorderRadius.circular(4),
    ),
    contentPadding: const EdgeInsets.only(top: 14.0),
    prefixIcon: Icon(
      icon,
      color: kWhiteColor,
    ),
    labelText: label,
    labelStyle: const TextStyle(
      color: kLightTealColor,
    ),
    hintText: hint,
    hintStyle: const TextStyle(
      color: kLightTealColor,
    ),
    errorStyle: const TextStyle(
      color: Color(0XFFb90900),
    ),

    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0XFFb90900), width: 1),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0XFFb90900), width: 1),
    ),
  );
}

InputDecoration inputDecorationOnWhite(
  String label,
  String hint,
) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kTealColor),
      borderRadius: BorderRadius.circular(4),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kLightTealColor),
      borderRadius: BorderRadius.circular(4),
    ),
    labelText: label,
    labelStyle: const TextStyle(
      color: kLightTealColor,
    ),
    hintText: hint,
    hintStyle: const TextStyle(
      color: kLightDivide,
    ),
    errorStyle: const TextStyle(
      color: Color(0XFFb90900),
    ),
  );
}
