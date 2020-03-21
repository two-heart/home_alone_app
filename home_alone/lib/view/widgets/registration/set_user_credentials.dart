import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/registration_store.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/viewmodel/registration_model.dart';

class SetUserCredentials extends StatelessWidget {
  final RegistrationModel model;

  const SetUserCredentials({this.model});
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildGreetingText(context),
              // _buildUserNameTextField(),
              Expanded(child: Container()),
              _buildRegisterButton(),
            ],
          ),
        ),
      );

  Widget _buildRegisterButton() => ThemedButton(
        onPressed: model.usernameIsValid
            ? locator.get<RegistrationStore>().goToNextStep
            : null,
        text: "Übernehmen und weiter",
      );

  _buildGreetingText(BuildContext context) {
    return ThemedText(text: 'Schön, dich kennen zu lernen, ${model.username}');
  }
}
