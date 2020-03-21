import 'package:flutter/material.dart';

class CategoryModel extends ChangeNotifier {
  CategoryModel({this.name});
  final String name;

  bool _isSelected;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    isSelected = value;
    notifyListeners();
  }
}
