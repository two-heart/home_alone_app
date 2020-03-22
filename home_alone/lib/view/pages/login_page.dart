import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/login/login_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:provider/provider.dart';

import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/viewmodel/login_model.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';

class AwfulKeyboardMixin {
  double maxHeight = 0;
  double getContentHeightForAwfulKeyboard(BoxConstraints constraints) {
    if (this.maxHeight < constraints.maxHeight) {
      this.maxHeight = constraints.maxHeight;
    }
    return this.maxHeight;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AwfulKeyboardMixin {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    locator.get<LoginStore>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var container = SafeArea(
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
    return container.withAwfulKeyboardFix(this);
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
            _buildTextFields(context),
          ],
        ),
      );

  Widget _buildGreetingText() => ThemedText(
        text: "Willkommen zurück!",
        fontSize: HomeAloneDimensions.welcomeHeaderTextSize,
      );

  Widget _buildTextFields(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildEmailTextField(context),
          SizedBox(height: 20),
          _buildPasswordTextField(context),
        ],
      );

  Widget _buildEmailTextField(BuildContext context) {
    final model = Provider.of<LoginModel>(context);
    final store = locator.get<LoginStore>();
    return TextField(
      onChanged: store.onEmailTextChanged,
      cursorColor: Theme.of(context).accentColor,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
        errorText: model.hasError ? model.errorMessage : null,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        filled: false,
        hintStyle: new TextStyle(color: Theme.of(context).hintColor),
        hintText: "E-Mail",
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    final model = Provider.of<LoginModel>(context);
    final store = locator.get<LoginStore>();
    return TextField(
        // Possibly factor this out together with email field
        cursorColor: Theme.of(context).accentColor,
        controller: passwordController,
        obscureText: true,
        onChanged: store.onPasswordTextChanged,
        decoration: new InputDecoration(
          errorText: model.hasError ? model.errorMessage : null,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: false,
          hintStyle: new TextStyle(color: Theme.of(context).hintColor),
          hintText: "Passwort",
        ));
  }

  _buildButtons(BuildContext context) => Column(
        children: <Widget>[
          LoginButton(),
          SizedBox(height: 8),
          _buildRegisterButton(context),
        ],
      );

  Widget _buildRegisterButton(BuildContext context) => ThemedFlatButton(
        text: 'Noch kein Account?\nJetzt registrieren!',
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed("/register/setUsername"),
      );
}
