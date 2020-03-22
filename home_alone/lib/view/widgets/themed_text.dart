import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/theme/dime.dart';

class ThemedText extends StatelessWidget {
  const ThemedText({
    this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = HomeAloneDimensions.welcomeHeaderTextSize,
    this.fontWeight = FontWeight.w600,
    this.color = HomeAloneColors.mainGreen,
  });

  final TextAlign textAlign;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
}
