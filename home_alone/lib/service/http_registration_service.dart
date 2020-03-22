import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:home_alone/model/registration_credentials.dart';
import 'package:home_alone/service/ext.dart';

class HttpRegistrationService {
  final Dio dio;
  final String baseUrl;
  String token;

  HttpRegistrationService({
    @required this.dio,
    @required this.baseUrl,
  });

  Future<void> registerUser(RegistrationCredentials credentials) async {
    await dio.post(
      "$baseUrl/auth/register",
      data: {
        "displayedName": credentials.username,
        "email": credentials.email,
        "plainPassword": credentials.password,
      },
    );
  }
}
