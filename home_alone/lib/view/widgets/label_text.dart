import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/theme/dime.dart';

class LabelText extends StatelessWidget {
  LabelText({
    this.text,
    this.fontWeight = FontWeight.normal,
  });
  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: HomeAloneColors.headerTextGrey,
          fontSize: HomeAloneDimensions.labelFontSize,
          fontWeight: fontWeight,
        ),
      );
}
