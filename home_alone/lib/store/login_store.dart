import 'package:flutter/material.dart';
import 'package:home_alone/viewmodel/login_model.dart';

class LoginStore {
  LoginStore(
    this.loginModel,
  );
  final LoginModel loginModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onEmailTextChanged(String value) {
    loginModel.email = value;
  }

  void onPasswordTextChanged(String value) {
    loginModel.password = value;
  }

  Future<void> onLoginButtonPressed() async {
    //TODO: call Login service, do stuff
  }
}
