import 'package:flutter/material.dart';

enum AppState { welcome, register, login, loggedIn }

class AppModel extends ChangeNotifier {
  AppState _appState = AppState.welcome;
  AppState get appState => _appState;
  set appState(AppState newState) {
    _appState = newState;
    notifyListeners();
  }
}
