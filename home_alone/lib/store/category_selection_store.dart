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
        categorySelectionModel.categories._getIdsOfSelected();
    print("lol");
    print(selectedCategories);

    await categorySelectionService.selectCategories(selectedCategories);

    final categories = await loadSelectedCategories();
    print(categories);
  }

  Future<List<Category>> loadSelectedCategories() async {
    await loadCategories();
    final categories = await categorySelectionService.getUsersCategories();
    // print(categories);
    if (categories?.isNotEmpty != true) {
      return null;
    }
    categories.forEach((category) {
      categorySelectionModel.categories
          .firstWhere((c) => c.category.id == category.id)
          .isSelected = true;
    });
    return categories..forEach((f) => print(f.id));
  }
}

extension on List<CategoryModel> {
  List<String> _getIdsOfSelected() =>
      this.where((f) => f.isSelected).map((f) => f.category.id).toList();
}
