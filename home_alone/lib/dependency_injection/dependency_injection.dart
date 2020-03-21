import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/service/challenge/fakes/fake_challenge_api.dart';
import 'package:home_alone/service/challenge/http_challenge_api.dart';
import 'package:home_alone/service/http_login_service.dart';
import 'package:home_alone/service/http_registration_service.dart';
import 'package:home_alone/store/category_selection_store.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/store/registration_store.dart';
import 'package:home_alone/viewmodel/app_model.dart';
import 'package:home_alone/viewmodel/category_selection_model.dart';
import 'package:home_alone/viewmodel/login_model.dart';
import 'package:home_alone/viewmodel/registration_model.dart';

class DependencyInjection {
  static Future<void> setUp() async {
    await DotEnv().load('.env');
    _setUpServices();
    _setUpViewModels();
    _setUpStores();
  }

  static String token;

  static void _setUpServices() {
    var dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));

    dio = addInterceptors(dio);

    /*locator.registerSingleton<ChallengeApi>(
      HttpChallengeApi(
          baseUrl: DotEnv().env['BASE_URL'],
          dio: dio,
      )
    );*/

    locator.registerSingleton<ChallengeApi>(FakeChallengeApi());
    locator.registerSingleton<HttpRegistrationService>(HttpRegistrationService(
      dio: dio,
      baseUrl: DotEnv().env['BASE_URL'],
    ));
    locator.registerSingleton<HttpLoginService>(HttpLoginService(
      dio: dio,
      baseUrl: DotEnv().env['BASE_URL'],
    ));
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(
          onResponse: (Response response) => responseInterceptor(response),
          onRequest: (RequestOptions options) => requestInterceptor(options),
          onError: (DioError dioError) => dioError));
  }

  static dynamic responseInterceptor(Response options) async {
    if (options.request.method != 'POST') return options;
    if (options.statusCode < 299) {
      var data = options.data as Map<String, dynamic>;
      if (data.containsKey('accessToken')) {
        token = data['accessToken'];
      }
    }
    return options;
  }

  static dynamic requestInterceptor(RequestOptions options) {
    if (token == null) return options;
    options.headers.addAll({"Authorization": "Bearer " + token});
    print('token set');
    return options;
  }

  static void _setUpViewModels() {
    locator.registerSingleton<AppModel>(AppModel());
    locator.registerSingleton<RegistrationModel>(RegistrationModel());
    locator.registerSingleton<LoginModel>(LoginModel());
    locator.registerSingleton<CategorySelectionModel>(CategorySelectionModel());
    // print('emailValid: ${locator.get<LoginModel>().isLoginButtonEnabled}');
  }

  static void _setUpStores() {
    locator.registerSingleton(LoginStore(
      locator.get<LoginModel>(),
      locator.get<HttpLoginService>(),
    ));
    locator.registerSingleton(RegistrationStore(
      locator.get<RegistrationModel>(),
      locator.get<HttpRegistrationService>(),
    ));
    locator.registerSingleton(CategorySelectionStore(
      locator.get<CategorySelectionModel>(),
      // locator.get<HttpRegistrationService>(),
    ));
  }
}
