import 'package:flutter/material.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/view/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/viewmodel/login_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Login"),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider.value(
        value: locator.get<LoginModel>(),
        child: Builder(
          builder: (context) => Consumer<LoginModel>(
            builder: (context, loginModel, _) =>
                _buildContent(context, loginModel),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, LoginModel loginModel) =>
      Container(
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEmailTextField(context, loginModel),
            _buildPasswordTextField(context, loginModel),
            _buildLoginButton(context, loginModel),
          ],
        ),
      );

  RaisedButton _buildLoginButton(BuildContext context, LoginModel loginModel) {
    return
      RaisedButton(
      child: Text(
        "Login",
        style: TextStyle(),
        textScaleFactor: HomeAloneDimensions.loginButtonTextScale,
      ),
      color: Theme.of(context).buttonColor,
      padding: EdgeInsets.symmetric(
          horizontal: HomeAloneDimensions.loginButtonVerticalPadding,
          vertical: HomeAloneDimensions.loginButtonVerticalPadding),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      onPressed: loginModel.isLoginButtonEnabled
          ? () async {
              // clear the current focus to dismiss the keyboard
              FocusScope.of(context).requestFocus(FocusNode());
              await locator.get<LoginStore>().onLoginButtonPressed();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            }
          : null,
    );
  }

  Widget _buildEmailTextField(BuildContext context, LoginModel loginModel) {
    final store = locator.get<LoginStore>();
    return TextField(
      controller: store.emailController,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: false,
          hintStyle: new TextStyle(color: Theme.of(context).hintColor),
          hintText: "Username",),//TODO i18n
      onChanged: store.onEmailTextChanged,
    );
  }

  Widget _buildPasswordTextField(BuildContext context, LoginModel loginModel) {
    final store = locator.get<LoginStore>();
    return TextField(  // Possibly factor this out together with email field
      controller: store.passwordController,
      obscureText: true,
      onChanged: store.onPasswordTextChanged,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: false,
          hintStyle: new TextStyle(color: Theme.of(context).hintColor),
          hintText: "Password",) //TODO i18n
    );
  }
}

// class TextFieldWrapper extends FormField<String> {}

// class EmailTextField extends StatelessWidget {
//   EmailTextField({
//     Key key,
//     this.controller,
//     this.textInputAction,
//     this.onSubmitted,
//     this.focusNode,
//     this.onChange,
//     this.validator,
//     this.isEnabled,
//   }) : super(key: key);

//   final RegExp _mailRegExp = RegExp(
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
//   final TextEditingController controller;
//   final TextInputAction textInputAction;
//   final Function(String) onSubmitted;
//   final FocusNode focusNode;
//   final FormFieldSetter<String> onChange;
//   final FormFieldValidator<String> validator;
//   final bool isEnabled;

//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//         label: 'Email',
//         keyboardInputType: TextInputType.emailAddress,
//         controller: controller,
//         textInputAction: textInputAction,
//         enabled: isEnabled,
//         onChange: onChange,
//         onSubmitted: onSubmitted,
//         focusNode: focusNode,
//         validator: (data) {
//           if (validator != null) {
//             return validator(data);
//           }

//           if (!_mailRegExp.hasMatch(data)) {
//             return "Email is not correct";
//           }

//           return null;
//         });
//   }
