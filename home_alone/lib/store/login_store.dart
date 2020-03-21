import 'package:flutter/material.dart';
import 'package:home_alone/model/login_credentials.dart';
import 'package:home_alone/service/http_login_service.dart';
import 'package:home_alone/viewmodel/login_model.dart';

class LoginStore {
  LoginStore(
    this.loginModel,
    this.loginService,
  );
  final LoginModel loginModel;
  final HttpLoginService loginService;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onEmailTextChanged(String value) {
    loginModel.email = value;
  }

  void onPasswordTextChanged(String value) {
    loginModel.password = value;
  }

  Future<bool> onLoginButtonPressed() async {
    try {
      await this.loginService.loginWithCredentials(
          LoginCredentials(loginModel.email, loginModel.password));
      return true;
    } catch (err) {
      return false;
    }
  }
}
