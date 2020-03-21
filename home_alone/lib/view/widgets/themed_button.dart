import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/login_store.dart';
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
    final store = locator.get<LoginStore>();
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.symmetric(
          horizontal: HomeAloneDimensions.loginButtonVerticalPadding,
          vertical: HomeAloneDimensions.loginButtonVerticalPadding),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      child: child,
    );
  }
}
