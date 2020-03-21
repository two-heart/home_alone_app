import 'package:flutter/material.dart';
import 'package:home_alone/viewmodel/category_model.dart';

class CategorySelectionModel extends ChangeNotifier {
  List<CategoryModel> _categories = List<CategoryModel> ();
  List<CategoryModel> get categories => _categories;
  set categories(List<CategoryModel> value) {
    _categories = value;
    notifyListeners();
  }

  bool get actionButtonIsEnabled => _categories.any((f) => f.isSelected);
}
