import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/service/challenge/fakes/fake_challenge_api.dart';
import 'package:home_alone/service/challenge/http_challenge_api.dart';
import 'package:home_alone/store/login_store.dart';
import 'package:home_alone/viewmodel/login_model.dart';

class DependencyInjection {
  static Future<void> setUp() async {
    await DotEnv().load('.env');
    _setUpServices();
    _setUpViewModels();
    _setUpStores();
  }

  static void _setUpServices() {
    final dio = Dio();

    locator.registerSingleton<ChallengeApi>(
      HttpChallengeApi(
          baseUrl: DotEnv().env['BASE_URL'],
          dio: dio,
      )
    );
    locator.registerSingleton<ChallengeApi>(
      FakeChallengeApi(),
    );
  }

  static void _setUpViewModels() {
    locator.registerSingleton<LoginModel>(LoginModel());
    print('emailValid: ${locator.get<LoginModel>().isLoginButtonEnabled}');
  }

  static void loadWeather() {
    // locator.get<WeatherStore>()
    //   ..loadCurrentWeather("Darmstadt")
    //   ..loadWeatherForecast("Darmstadt");
  }

  static void _setUpStores() {
    // locator.registerSingleton<WeatherStore>(WeatherStore(
    //   api: locator.get<OpenWeatherApi>(),
    //   weather: locator.get<WeatherModel>(),
    // ));

    locator.registerSingleton(LoginStore(locator.get<LoginModel>()));
  }
}
