import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/view/pages/home_page.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/viewmodel/login_model.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<LoginModel>(
        builder: (context, loginModel, _) => ThemedButton(
          onPressed:
              loginModel.isLoginButtonEnabled ? () => _login(context) : null,
          child: _buildText(),
        ),
      );

  Text _buildText() {
    return Text(
      "Login",
      style: TextStyle(color: Colors.white),
      textScaleFactor: HomeAloneDimensions.loginButtonTextScale,
    );
  }

  void _login(BuildContext context) async {
    // clear the current focus to dismiss the keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    await locator.get<LoginStore>().onLoginButtonPressed();

    // Reset navigation stack and push home screen
    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  }
}
