import 'dart:ui';

const kAppBarBackground = Color(0xFFF0F4F7);
const kLightBackground = Color(0xFFfbfbfb);
const kLightDivide = Color(0xFFb8bcbf);
const kButtonColor = Color(0xFF00abb6);
const kTealColor = Color(0xFF00abb6);
const kLightTealColor = Color(0XFF82e0e2);
const kWhiteColor = Color(0XFFFFFFFF);
const kTeal100Color = Color(0XFFb3ecec);
const kDarkGrey = Color(0xFF181A18);
const kLightGrey = Color(0xFF90A4AE);



extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
