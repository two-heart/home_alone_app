import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/registration_store.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/viewmodel/registration_model.dart';
import 'package:provider/provider.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';

class RegistrationPage extends StatelessWidget {
  bool isStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Benutzer registrieren")),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return ChangeNotifierProvider.value(
      value: locator.get<RegistrationModel>(),
      child: Builder(
        builder: (context) => Consumer<RegistrationModel>(
          builder: _buildContent,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    RegistrationModel model,
    _,
  ) =>
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildGreetingAndTextFields(context, model),
                _buildButtons(model, context),
              ],
            ),
          )).withWeirdBall();

  Widget _buildGreetingAndTextFields(
          BuildContext context, RegistrationModel model) =>
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildGreetingText(model),
            SizedBox(height: 30),
            _buildTextFields(context),
          ],
        ),
      );

  _buildGreetingText(RegistrationModel model) =>
      ThemedText(text: 'Schön, dich kennen zu lernen, ${model.username}');

  Widget _buildTextFields(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildEmailTextField(context),
          SizedBox(height: 20),
          _buildPasswordTextField(context),
        ],
      );

  Widget _buildEmailTextField(BuildContext context) {
    final store = locator.get<RegistrationStore>();
    return TextField(
      cursorColor: Theme.of(context).accentColor,
      controller: store.emailController,
      onChanged: (t) => store.registrationModel.email = t,
      decoration: new InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        filled: false,
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        hintText: "E-Mail",
      ), //TODO i18n
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    final store = locator.get<RegistrationStore>();
    return TextField(
        // Possibly factor this out together with email field
        cursorColor: Theme.of(context).accentColor,
        controller: store.passwordController,
        onChanged: (t) => store.registrationModel.password = t,
        obscureText: true,
        decoration: new InputDecoration(
          errorText: store.registrationModel.registrationHasError
              ? 'Nutzername und/oder Passwort nicht korrekt'
              : null,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
          ),
          filled: false,
          hintStyle: new TextStyle(color: Theme.of(context).hintColor),
          hintText: "Password",
        ) //TODO i18n
        );
  }

  _buildButtons(RegistrationModel model, BuildContext context) => Column(
        children: <Widget>[
          _buildRegisterButton(context, model),
          SizedBox(height: 8),
          _buildLoginButton(context),
        ],
      );

  Widget _buildRegisterButton(BuildContext context, RegistrationModel model) {
    final model = Provider.of<RegistrationModel>(context);
    final submit = () async {
      if (await registerUser(context)) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    };
    return ThemedButton(
      onPressed: model.registerButtonIsEnabled ? submit : null,
      text: "Zugangsdaten speichern",
      alternativeChild: model.isLoading ? CircularProgressIndicator() : null,
    );
  }

  Widget _buildLoginButton(BuildContext context) => ThemedFlatButton(
        text: 'Einloggen',
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed("/register/setUsername"),
      );

  Future<bool> registerUser(BuildContext context) async {
    try {
      await locator.get<RegistrationStore>().registerUser();
      return true;
    } catch (error) {
      return false;
    }
  }
}
