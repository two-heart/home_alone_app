import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/theme/dime.dart';

class ThemedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double textScaleFactor;
  final Widget alternativeChild;
  final double width;
  final double padding;

  const ThemedButton({
    this.onPressed,
    this.text = "",
    this.textScaleFactor = 1.0,
    this.alternativeChild,
    this.width,
    this.padding = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                HomeAloneDimensions.primaryButtonBorderRadius)),
        color: Colors.transparent,
        onPressed: onPressed,
        textColor: HomeAloneColors.primaryButtonTextColor,
        padding: const EdgeInsets.all(0.0),
        child: Container(
            width: width == null ? 300 : width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                    HomeAloneDimensions.primaryButtonBorderRadius)),
                gradient: LinearGradient(
                  colors: [
                    HomeAloneColors.primaryButtonGradientStartColor,
                    HomeAloneColors.primaryButtonGradientEndColor,
                  ],
                )),
            padding: EdgeInsets.all(padding),
            child: alternativeChild != null ? alternativeChild : _buildText()),
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
