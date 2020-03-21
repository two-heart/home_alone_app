import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/viewmodel/login_model.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  Function loginFailed;
  LoginButton({@required this.loginFailed});

  @override
  Widget build(BuildContext context) => Consumer<LoginModel>(
        builder: (context, loginModel, _) => ThemedButton(
          onPressed:
              loginModel.isLoginButtonEnabled ? () => _login(context) : null,
          text: "Einloggen",
          textScaleFactor: HomeAloneDimensions.loginButtonTextScale,
        ),
      );

  void _login(BuildContext context) async {
    // clear the current focus to dismiss the keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    final loginResult = await locator.get<LoginStore>().onLoginButtonPressed();
    if (loginResult) {
      // Reset navigation stack and push home screen
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    } else {
      this.loginFailed();
    }
  }
}
