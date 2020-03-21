import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/theme/dime.dart';

class ThemedText extends StatelessWidget {
  const ThemedText({
    this.text,
    this.fontSize = HomeAloneDimensions.welcomeHeaderTextSize,
    this.fontWeight = FontWeight.w600,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: HomeAloneColors.mainGreen,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
}
