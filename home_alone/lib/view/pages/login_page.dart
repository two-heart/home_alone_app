import 'package:flutter/material.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/view/widgets/login/login_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:provider/provider.dart';

import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/viewmodel/login_model.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ChangeNotifierProvider.value(
          value: locator.get<LoginModel>(),
          child: Builder(
            builder: (context) => _buildContent(context).withWeirdBall(
              builder: (child) => Center(child: child),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildGreetingAndTextFields(context),
            _buildButtons(context),
          ],
        ),
      );

  Widget _buildGreetingAndTextFields(BuildContext context) => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildGreetingText(),
            SizedBox(height: 30),
            _buildTexts(context),
          ],
        ),
      );

  Widget _buildGreetingText() => ThemedText(text: "Willkommen zurück!");

  Widget _buildTexts(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildEmailTextField(context),
          SizedBox(height: 20),
          _buildPasswordTextField(context),
        ],
      );

  Widget _buildEmailTextField(BuildContext context) {
    final store = locator.get<LoginStore>();
    return TextField(
      cursorColor: Theme.of(context).accentColor,
      controller: store.emailController,
      decoration: new InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        filled: false,
        hintStyle: new TextStyle(color: Theme.of(context).hintColor),
        hintText: "Username",
      ), //TODO i18n
      onChanged: store.onEmailTextChanged,
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    final store = locator.get<LoginStore>();
    return TextField(
        // Possibly factor this out together with email field
        cursorColor: Theme.of(context).accentColor,
        controller: store.passwordController,
        obscureText: true,
        onChanged: store.onPasswordTextChanged,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: false,
          hintStyle: new TextStyle(color: Theme.of(context).hintColor),
          hintText: "Password",
        ) //TODO i18n
        );
  }

  Widget _buildRegisterButton(BuildContext context) => ThemedFlatButton(
        text: 'Noch kein Account?\nJetzt registrieren!',
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed("/register/setUsername"),
      );

  _buildButtons(BuildContext context) => Column(
        children: <Widget>[
          LoginButton(),
          SizedBox(height: 8),
          _buildRegisterButton(context),
        ],
      );
}
