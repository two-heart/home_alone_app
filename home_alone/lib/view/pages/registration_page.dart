import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/registration_response.dart';
import 'package:home_alone/store/registration_store.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/viewmodel/registration_model.dart';
import 'package:provider/provider.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';

class RegistrationPage extends StatelessWidget {
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
      Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildGreetingText(model),
              // _buildUserNameTextField(),
              Expanded(child: Container()),
              _buildRegisterButton(context, model),
            ],
          ),
        ),
      );

  Widget _buildRegisterButton(BuildContext context, RegistrationModel model) =>
      ThemedButton(
        onPressed: model.usernameIsValid ? () => _registerUser(context) : null,
        text: "Übernehmen und weiter",
      );

  _buildGreetingText(RegistrationModel model) {
    return ThemedText(text: 'Schön, dich kennen zu lernen, ${model.username}');
  }

  Future<void> _registerUser(BuildContext context) async {
    await locator
        .get<RegistrationStore>()
        .registerUser()
        .then((RegistrationResponse response) {
      if (response.isSuccessful) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }).catchError((_) {
      print("error registering user");
    });
  }
}
