import 'package:flutter/material.dart';

class HomeAloneColors {
  static const Color mainGreen = DarkColor(0xFF39C87C);
  static const primaryColor = mainGreen;
  static const primaryLightColor = Color(0xFF0ff39c);
  static const primaryDarkColor = Color(0x00bf6d);
  static const primaryTextColor = Color(0x000000);

  static const Color primaryButtonGradientStartColor =
      Color.fromARGB(255, 149, 242, 168);
  static const Color primaryButtonGradientEndColor =
      Color.fromARGB(255, 0, 191, 146);
  static const Color primaryButtonTextColor = Colors.white;

  static const flatButtonGrey = Color(0xFFA2A2A2);
  static const headerTextGrey = Color(0xFF5E5E5E);

  static var categoryIconColor = Color(0xFF00AB96);
}

class DarkColor extends Color {
  const DarkColor(int value) : super(value);

  @override
  double computeLuminance() {
    return 0;
  }
}