import 'package:dio/dio.dart';
import 'package:home_alone/model/current_weather.dart';
import 'package:home_alone/model/weather_forecast.dart';
import 'package:home_alone/service/open_weather_api.dart';

class HttpOpenWeatherApi implements OpenWeatherApi {
  String baseUrl;
  Dio dio;

  Map<String, dynamic> defaultQueryParams;

  HttpOpenWeatherApi({apiKey, this.baseUrl, this.dio})
      : defaultQueryParams = {
          "APPID": apiKey,
          "units": "metric",
        };

  @override
  Future<CurrentWeather> loadCurrentWeather(String city) async {
    var response = await dio.get("$baseUrl/data/2.5/weather",
        queryParameters: {"q": city, ...defaultQueryParams});
    return CurrentWeather.fromJson(response.data);
  }

  @override
  Future<WeatherForecast> loadWeatherForecast(String city) async {
    var response = await dio.get("$baseUrl/data/2.5/forecast",
        queryParameters: {"q": city, ...defaultQueryParams});
    print(response);
    return WeatherForecast.fromJson(response.data);
  }
}
