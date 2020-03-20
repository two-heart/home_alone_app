import 'package:home_alone/model/current_weather.dart';
import 'package:home_alone/model/weather_forecast.dart';

abstract class OpenWeatherApi {
  Future<CurrentWeather> loadCurrentWeather(String city);
  Future<WeatherForecast> loadWeatherForecast(String city);
}
