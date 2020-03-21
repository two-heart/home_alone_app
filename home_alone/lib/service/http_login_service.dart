import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:home_alone/model/login_credentials.dart';
import 'package:home_alone/model/user.dart';

class HttpLoginService {
  final Dio dio;
  final String baseUrl;

  HttpLoginService({
    @required this.dio,
    @required this.baseUrl,
  });

  Future<void> loginWithCredentials(LoginCredentials credentials) async {
    var response = await dio.get(
      "$baseUrl/auth/login",
      queryParameters: {
        "username": credentials.email,
        "password": credentials.password,
      },
    );

    // User.fromJson(response);
  }
}
