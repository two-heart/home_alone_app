import 'package:flutter/material.dart';

enum RegistrationStep { setUsername, register }

class RegistrationModel extends ChangeNotifier {
  bool get usernameIsValid => username?.isNotEmpty == true;
  bool get registerButtonIsEnabled =>
      username?.isNotEmpty == true &&
      email?.isNotEmpty == true &&
      password?.isNotEmpty == true;

  RegistrationStep _registrationStep = RegistrationStep.setUsername;
  RegistrationStep get registrationStep => _registrationStep;
  set registrationStep(RegistrationStep nextStep) {
    _registrationStep = nextStep;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _username;
  String get username => _username;
  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String _email;
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password;
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String _passwordRepeat;
  String get passwordRepeat => _passwordRepeat;
  set passwordRepeat(String value) {
    _passwordRepeat = value;
    notifyListeners();
  }
}
