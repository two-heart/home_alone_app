import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:home_alone/model/login_credentials.dart';
import 'package:home_alone/service/ext.dart';

class HttpLoginService {
  final Dio dio;
  final String baseUrl;

  HttpLoginService({
    @required this.dio,
    @required this.baseUrl,
  });

  Future<bool> loginWithCredentials(LoginCredentials credentials) async {
    try {
      var response = await dio.post(
        "$baseUrl/auth/login",
        data: {
          "username": credentials.email,
          "password": credentials.password,
        },
      );
      return response.evaluate(((item) => item));
    } catch (error) {
      final dioError = error as DioError;
      return dioError.response.evaluate((item) => item);
    }
  }
}
