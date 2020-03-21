import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/theme/dime.dart';

class ThemedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double textScaleFactor;

  const ThemedButton({
    this.onPressed,
    this.text = "",
    this.textScaleFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.transparent,
        onPressed: () {},
        textColor: HomeAloneColors.primaryButtonTextColor,
        padding: const EdgeInsets.all(0.0),
        child: Container(
            width: 300,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                gradient: new LinearGradient(
                  colors: [
                    HomeAloneColors.primaryButtonGradientStartColor,
                    HomeAloneColors.primaryButtonGradientEndColor,
                  ],
                )),
            padding: const EdgeInsets.all(10.0),
            child: _buildText()),
      ),
    );
  }

  Text _buildText() {
    return Text(text,
        textAlign: TextAlign.center,
        textScaleFactor: textScaleFactor,
        style: TextStyle(
          fontSize: HomeAloneDimensions.primaryButtonTextSize,
          fontWeight: FontWeight.bold,
        ));
  }
}

/**
 *
 * EdgeInsets.symmetric(
    horizontal: HomeAloneDimensions.loginButtonVerticalPadding,
    vertical: HomeAloneDimensions.loginButtonVerticalPadding)
 */
