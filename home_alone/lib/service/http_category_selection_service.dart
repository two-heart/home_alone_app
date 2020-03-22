import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:home_alone/model/category.dart';


class HttpCategorySelectionService {
  HttpCategorySelectionService({
    this.dio,
    this.baseUrl,
  });

  final Dio dio;
  final String baseUrl;

  Future<List<Category>> getAllCategories() async {
    var response = await dio.get("$baseUrl/category");
    return Category.fromJsonList(response.data);
  }

  selectCategories(List<String> selectedCategories) async {
    final data = {"categoryIds": selectedCategories};
    print(data);

    var response = await dio.post(
      "$baseUrl/user/categories",
      data: data,
    );
    print(response);
  }
}
