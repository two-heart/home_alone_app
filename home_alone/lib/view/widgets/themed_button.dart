import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/dime.dart';

class ThemedButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const ThemedButton({
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.transparent,
        onPressed: () {},
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
            width: 300,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                gradient: new LinearGradient(
                  colors: [
                    Color.fromARGB(255, 149, 242, 168),
                    Color.fromARGB(255, 0, 191, 146)
                  ],
                )),
            padding: const EdgeInsets.all(10.0),
            child: child),
      ),
    );
  }
}

/**
 *
 * EdgeInsets.symmetric(
    horizontal: HomeAloneDimensions.loginButtonVerticalPadding,
    vertical: HomeAloneDimensions.loginButtonVerticalPadding)
 */
