import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/border.dart';

class ThemedAppBar extends AppBar {
  ThemedAppBar({String title = "Home Alone", actions, showLogo = false}): super(
    centerTitle: true,
    shape: CurvedAppBarBorder(),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),
    ),
    actions: actions,
    leading: showLogo ? Icon(Icons.print) : null
  );
}
