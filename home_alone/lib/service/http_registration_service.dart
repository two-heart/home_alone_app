import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:home_alone/model/registration_credentials.dart';

class HttpRegistrationService {
  final Dio dio;
  final String baseUrl;

  HttpRegistrationService({
    @required this.dio,
    @required this.baseUrl,
  });

  Future<void> registerUser(RegistrationCredentials credentials) async {
    var response = await dio.get(
      "$baseUrl/register",
      queryParameters: {
        "email": credentials.email,
        "password": credentials.password,
        "username": credentials.username
      },
    );

    // User.fromJson(response);
  }
}
