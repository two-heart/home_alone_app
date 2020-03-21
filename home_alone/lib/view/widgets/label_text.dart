import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/theme/dime.dart';

class LabelText extends StatelessWidget {
  LabelText({
    this.text,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
  });
  final String text;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: HomeAloneColors.headerTextGrey,
          fontSize: HomeAloneDimensions.labelFontSize,
          fontWeight: fontWeight,
        ),
      );
}
