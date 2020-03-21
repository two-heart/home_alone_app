import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:home_alone/model/login_credentials.dart';
import 'package:home_alone/service/ext.dart';

class LoginResponse {
  final int statusCode;
  LoginResponse(this.statusCode);
  factory LoginResponse.error() => LoginResponse(500);
}

class HttpLoginService {
  final Dio dio;
  final String baseUrl;

  HttpLoginService({
    @required this.dio,
    @required this.baseUrl,
  });

  Future<LoginResponse> loginWithCredentials(
      LoginCredentials credentials) async {
    try {
      final response = await dio.post(
        "$baseUrl/auth/login",
        data: credentials.toJson(),
      );

      return LoginResponse(response.statusCode);
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return LoginResponse(error.response.statusCode);
        }
      }
      return LoginResponse.error();
    }
  }
}
