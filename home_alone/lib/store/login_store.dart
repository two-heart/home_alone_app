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

  void onEmailTextChanged(String value) {
    loginModel.email = value;
    _resetErrorStateIfNecessary();
  }

  void onPasswordTextChanged(String value) {
    loginModel.password = value;
    _resetErrorStateIfNecessary();
  }

  void _resetErrorStateIfNecessary() {
    loginModel.resetErrorStateIfNecessary();
  }

  void reset() {
    loginModel.reset();
  }

  Future<LoginResponseModel> onLoginButtonPressed() async {
    loginModel.isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 1000));

    final response = await this.loginService.loginWithCredentials(
        LoginCredentials(loginModel.email, loginModel.password));

    final statusCode = response.statusCode;
    loginModel.hasError = response.statusCode > 299;
    loginModel.errorMessage = errorMessages[statusCode];
    loginModel.isLoading = false;
    final success = statusCode < 299;
    notifyListeners();

    return LoginResponseModel(
        success: success, errorMessage: errorMessages[statusCode] ?? '');
  }
}
