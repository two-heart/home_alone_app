import 'package:flutter/material.dart';
import 'package:home_alone/viewmodel/category_model.dart';

class CategorySelectionModel extends ChangeNotifier {
  List<CategoryModel> _categories = List<CategoryModel>();
  List<CategoryModel> get categories => _categories;
  set categories(List<CategoryModel> value) {
    _categories = value;
    _categories?.forEach((f) => f.addListener(_notifyListeners));
    notifyListeners();
  }

  void _notifyListeners() {
    notifyListeners();
  }

  bool get actionButtonIsEnabled => _categories.any((f) => f.isSelected);

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
