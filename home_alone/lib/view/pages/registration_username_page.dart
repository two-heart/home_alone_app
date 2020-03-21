import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/registration_store.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/viewmodel/registration_model.dart';
import 'package:provider/provider.dart';

class SetUsernamePage extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 4, child: Container()),
              _buildGreetingText(context),
              Expanded(flex: 1, child: Container()),
              _buildQuestionText(context),
              _buildUserNameTextField(context),
              Expanded(flex: 4, child: Container()),
              Padding(
                child: _buildApplyButton(model),
                padding: EdgeInsets.only(bottom: 32),
              ),
            ],
          ),
        ),
      );

  Widget _buildGreetingText(BuildContext context) =>
      ThemedText(text: "Super dich an Board zu haben!");

  Widget _buildQuestionText(BuildContext context) => LabelText(
        text: "Wie willst du bei uns heißen?",
        fontWeight: FontWeight.bold,
      );

  _buildUserNameTextField(context) {
    final store = locator.get<RegistrationStore>();
    return Padding(
      child: TextField(
        cursorColor: Theme.of(context).accentColor,
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

  Widget _buildApplyButton(model) => LayoutBuilder(
        builder: (context, constraints) {
          // Reset navigation stack and push home screen
          var onPressed = model.usernameIsValid
              ? () => Navigator.of(context).pushNamed("/register")
              : null;
          return ThemedButton(
            onPressed: onPressed,
            text: "Übernehmen und weiter",
          );
        },
      );
}
