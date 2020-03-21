import 'package:flutter/material.dart';
import 'package:home_alone/model/login_credentials.dart';
import 'package:home_alone/service/http_login_service.dart';
import 'package:home_alone/viewmodel/login_model.dart';

class LoginResponseModel {
  final bool success;
  final String errorMessage;

  LoginResponseModel({@required this.success, this.errorMessage});

  factory LoginResponseModel.error(String errorMessage) =>
      LoginResponseModel(success: false, errorMessage: errorMessage);
}

class LoginStore with ChangeNotifier {
  final errorMessages = {
    401: 'E-Mail und/oder Passwort nicht korrekt.',
    403: 'Der Zugriff wurde verweigert.',
    500: 'Der Login konnte nicht verarbeitet werden.'
  };

  LoginStore(
    this.loginModel,
    this.loginService,
  );

  final LoginModel loginModel;
  final HttpLoginService loginService;

  bool isLoading = false;
  bool hasError = false;
  String errorMessage;

  void onEmailTextChanged(String value) {
    loginModel.email = value;
    _resetErrorStateIfNecessary();
  }

  void onPasswordTextChanged(String value) {
    loginModel.password = value;
    _resetErrorStateIfNecessary();
  }

  void _resetErrorStateIfNecessary() {
    if (hasError) {
      hasError = false;
      notifyListeners();
    }
  }

  Future<LoginResponseModel> onLoginButtonPressed() async {
    isLoading = true;
    notifyListeners();

    final response = await this.loginService.loginWithCredentials(
        LoginCredentials(loginModel.email, loginModel.password));

    final statusCode = response.statusCode;
    this.hasError = response.statusCode > 299;
    this.errorMessage = errorMessages[statusCode];
    isLoading = false;

    notifyListeners();

    return LoginResponseModel(
        success: statusCode < 299,
        errorMessage: errorMessages[statusCode] ?? '');
  }
}
