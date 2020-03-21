import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  String _errorMessage;
  String get errorMessage => _errorMessage;
  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  void reset() {
    email = '';
    password = '';
    isLoading = false;
    hasError = false;
    errorMessage = null;
  }

  void resetErrorStateIfNecessary() {
    if (hasError) {
      hasError = false;
      notifyListeners();
    }
  }

  bool get isPasswordFieldEnabled => _password?.isNotEmpty == true;
  bool get isLoginButtonEnabled =>
      _password?.isNotEmpty == true && _email?.isNotEmpty == true;
  bool get isEmailValid => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(_email);
}
