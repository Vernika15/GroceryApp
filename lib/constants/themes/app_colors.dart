import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(
    RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
    'hex color must be #rrggbb or #rrggbbaa',
  );

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class AppColors {
  static Color primary = hexToColor('#6CAF7A');
  static Color white = hexToColor('#ffffff');
  static Color black = hexToColor('#000000');
  static Color error = hexToColor('#B00020');
  static Color textColor = hexToColor('#181725');
  static Color subTextColor = hexToColor('#7C7C7C');
  static Color underlineColor = hexToColor('#E2E2E2');
  static Color logoutButtonColor = hexToColor('#F2F3F2');
}
