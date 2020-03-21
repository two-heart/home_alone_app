import 'package:flutter/material.dart';
import 'package:home_alone/model/registration_credentials.dart';
import 'package:home_alone/model/registration_response.dart';
import 'package:home_alone/service/http_registration_service.dart';
import 'package:home_alone/viewmodel/registration_model.dart';

class RegistrationStore {
  RegistrationStore(
    this.registrationModel,
    this.registrationService,
  );

  final RegistrationModel registrationModel;
  final HttpRegistrationService registrationService;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<RegistrationResponse> registerUser() async {
    final credentials = RegistrationCredentials(
      email: registrationModel.email,
      password: registrationModel.password,
      username: registrationModel.username,
    );
    await registrationService.registerUser(credentials);
  }

  void goToNextStep() {
    if (registrationModel.usernameIsValid) {
      registrationModel.registrationStep = RegistrationStep.register;
    }
  }
}
