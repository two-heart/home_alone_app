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
      "$baseUrl/auth/register",
      queryParameters: {
        "displayedName": credentials.username,
        "email": credentials.email,
        "plainPassword": credentials.password,
      },
    );

    // User.fromJson(response);
  }
}
