import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/view/pages/home_page.dart';
import 'package:home_alone/view/widgets/registration/set_username.dart';
import 'package:home_alone/viewmodel/registration_model.dart';
import 'package:provider/provider.dart';

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
  ) {
    if (model.registrationStep == RegistrationStep.setUsername) {
      return SetUsername(model: model);
    } else {
      return MyHomePage();
    }
  }
}
