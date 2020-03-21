import 'package:flutter/material.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/view/widgets/login/login_button.dart';
import 'package:provider/provider.dart';

import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/viewmodel/login_model.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Login"),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider.value(
        value: locator.get<LoginModel>(),
        child: Builder(
          builder: (context) => _buildContent(context)
              .withWeirdBall(builder: (child) => Center(child: child)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) => Container(
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEmailTextField(context),
            _buildPasswordTextField(context),
            LoginButton()
          ],
        ),
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
}
