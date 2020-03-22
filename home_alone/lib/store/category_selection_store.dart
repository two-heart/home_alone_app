import 'package:dio/dio.dart';
import 'package:home_alone/model/category.dart';
import 'package:home_alone/service/http_category_selection_service.dart';
import 'package:home_alone/viewmodel/category_model.dart';
import 'package:home_alone/viewmodel/category_selection_model.dart';

import 'package:home_alone/service/ext.dart';

class CategorySelectionStore {
  final CategorySelectionModel categorySelectionModel;
  final HttpCategorySelectionService categorySelectionService;

  CategorySelectionStore(
    this.categorySelectionModel,
    this.categorySelectionService,
  );

  Future<void> loadCategories() async {
    categorySelectionModel.isLoading = true;
    try {
      List<Category> categories =
          await categorySelectionService.getAllCategories();
      categorySelectionModel.categories =
          categories.map((f) => CategoryModel(category: f)).toList();
    } catch (error) {
      // if (error is DioError) {
      //   if (error.response != null) {
      //     return LoginResponse(error.response.statusCode);
      //   }
      // }
      // return LoginResponse.error();
      print(error);
    }
    categorySelectionModel.isLoading = false;
  }

  Future<void> updateCategories() async {
    final selectedCategories =
        categorySelectionModel.categories.where((f) => f.isSelected).toList();
    // await categorySelectionService.updateCategories();
  }
}
