import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/registration_store.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/viewmodel/registration_model.dart';

class SetUsername extends StatelessWidget {
  final RegistrationModel model;

  const SetUsername({this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 4, child: Container()),
            _buildGreetingText(context),
            Expanded(flex: 1, child: Container()),
            _buildQuestionText(context),
            _buildUserNameTextField(),
            Expanded(flex: 4, child: Container()),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingText(BuildContext context) => Text(
        "Super dich an Board zu haben!",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display1,
      );

  Widget _buildQuestionText(BuildContext context) =>
      Text("Wie willst du bei uns heißen?");

  _buildUserNameTextField() {
    final store = locator.get<RegistrationStore>();
    return Padding(
      child: TextField(
        decoration: InputDecoration(
            fillColor: Color(0xF4F4F4),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xF4F4F4))),
            labelText: "Lege einen Benutzername fest:"),
        controller: store.userNameController,
        onChanged: (t) => store.registrationModel.username = t,
      ),
      padding: EdgeInsets.only(top: 12),
    );
  }

  Widget _buildApplyButton() => LayoutBuilder(
        builder: (context, constraints) {
          // Reset navigation stack and push home screen
          var onPressed = model.usernameIsValid
              ? () => Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home", (route) => false)
              : null;
          return ThemedButton(
            onPressed: onPressed,
            text: "Übernehmen und weiter",
          );
        },
      );
}
