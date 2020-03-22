import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/theme/dime.dart';

class ThemedFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double fontSize;

  const ThemedFlatButton({
    this.fontSize,
    this.text,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: HomeAloneColors.flatButtonGrey,
            fontSize: fontSize != null
                ? fontSize
                : HomeAloneDimensions.primaryButtonTextSize,
          ),
        ),
      );
}
