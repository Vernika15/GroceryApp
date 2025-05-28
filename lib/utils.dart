import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor)
    : super(int.parse(hexColor.replaceFirst('#', '0xff')));
}
