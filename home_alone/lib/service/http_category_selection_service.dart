import 'package:dio/dio.dart';
import 'package:home_alone/model/category.dart';

import 'package:home_alone/service/ext.dart';

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
}
