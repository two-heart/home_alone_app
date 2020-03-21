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

  Future<RegistrationResponse> registertUser() async {
    final credentials = RegistrationCredentials(
      email: registrationModel.email,
      password: registrationModel.password,
      username: registrationModel.username,
    );
    final response = await registrationService.registerUser(credentials);
    return RegistrationResponse(successful: true);
  }

  void goToNextStep() {
    if (registrationModel.usernameIsValid) {
      registrationModel.registrationStep = RegistrationStep.register;
    }
  }
}
