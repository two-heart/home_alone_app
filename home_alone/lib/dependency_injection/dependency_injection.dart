import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/service/http_open_weather_api.dart';
import 'package:home_alone/service/open_weather_api.dart';
import 'package:home_alone/store/weather_store.dart';
import 'package:home_alone/viewmodel/login_model.dart';
import 'package:home_alone/viewmodel/weather_model.dart';

class DependencyInjection {
  static Future<void> setUp() async {
    await DotEnv().load('.env');
    _setUpServices();
    _setUpViewModels();
    _setUpStores();
  }

  static void _setUpServices() {
    locator.registerSingleton<OpenWeatherApi>(
      HttpOpenWeatherApi(
        apiKey: DotEnv().env['API_KEY'],
        baseUrl: "http://api.openweathermap.org",
        dio: Dio(),
      ),
    );
  }

  static void _setUpViewModels() {
    locator.registerSingleton<WeatherModel>(WeatherModel());
    locator.registerSingleton<LoginModel>(LoginModel());
    print('emailValid: ${locator.get<LoginModel>().isLoginButtonEnabled}');
  }

  static void loadWeather() {
    locator.get<WeatherStore>()
      ..loadCurrentWeather("Darmstadt")
      ..loadWeatherForecast("Darmstadt");
  }

  static void _setUpStores() {
    locator.registerSingleton<WeatherStore>(WeatherStore(
      api: locator.get<OpenWeatherApi>(),
      weather: locator.get<WeatherModel>(),
    ));
  }
}
