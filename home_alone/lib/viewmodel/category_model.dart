import 'package:flutter/material.dart';
import 'package:home_alone/model/category.dart';

class CategoryModel extends ChangeNotifier {
  CategoryModel({
    this.category,
    bool isSelected = true,
  }) {
    _isSelected = isSelected;
  }
  Category category;

  bool _isSelected;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }
}
