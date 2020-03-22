import 'package:flutter/material.dart';

enum Tabs { discover, challenges, settings }

class AppModel extends ChangeNotifier {
  Tabs _tab = Tabs.discover;
  Tabs get tab => _tab;
  set tab(Tabs newTab) {
    _tab = newTab;
    _updateTabTitle();
    notifyListeners();
  }

  void _updateTabTitle() {
    switch (tab) {
      case Tabs.discover:
        currentTabTitle = 'Entdecken';
        break;
      case Tabs.challenges:
        currentTabTitle = 'Meine Challenges';
        break;
      case Tabs.settings:
        currentTabTitle = 'Einstellungen';
        break;
    }
  }

  String currentTabTitle = 'Entdecken';
}
