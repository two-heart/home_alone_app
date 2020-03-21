import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/user.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User user;

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void loadUser() async {
    var storage = locator.get<FlutterSecureStorage>();
    var value = await storage.read(key: "user");
    if (value == null) {
      return;
    }
    final user = User.fromJson(jsonDecode(value));
    setState(() {
      this.user = user;
    });
  }

  void onPressed() {
    locator.get<FlutterSecureStorage>().delete(key: "token");
    locator.get<FlutterSecureStorage>().delete(key: "user");
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final userWidget = user != null ? Text(user.displayedName) : Container();
    return Center(
        child: Column(
      children: [
        userWidget,
        RaisedButton(
          child: Text("Logout"),
          onPressed: onPressed,
        )
      ],
    ));
  }
}
