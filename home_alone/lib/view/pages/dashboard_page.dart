import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_alone/dependency_injection/locator.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Text("Dashboard"),
      RaisedButton(
        child: Text("Logout"),
        onPressed: () {
          locator.get<FlutterSecureStorage>().delete(key: "token");
          locator.get<FlutterSecureStorage>().delete(key: "username");
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/login", (route) => false);
        },
      )
    ]));
  }
}
