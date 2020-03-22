import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/user.dart';
import 'package:home_alone/view/pages/category_selection_page.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/themed_text.dart';

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

  @override
  Widget build(BuildContext context) {
    final userWidget = user != null
        ? ThemedText(
            text: 'Angemeldet als: ${user.displayedName}',
            fontSize: HomeAloneDimensions.labelFontSize,
          )
        : Container();
    return Center(
        child: Column(
      children: [
        userWidget,
        _buildCategorySelection(),
      ],
    ));
  }

  _buildCategorySelection() => Expanded(
        child: CategorySelection(
          fromSettings: true,
          buildScaffold: false,
        ),
      );
}
