import 'package:flutter/foundation.dart';
import 'package:home_alone/model/weather_forecast.dart';
import 'package:home_alone/service/open_weather_api.dart';
import 'package:home_alone/utils/forecast_utils.dart';
import 'package:home_alone/viewmodel/weather_data.dart';
import 'package:home_alone/viewmodel/weather_model.dart';

class WeatherStore {
  WeatherStore({
    @required this.api,
    @required this.weather,
  });

  final OpenWeatherApi api;
  final WeatherModel weather;

  Future<void> loadCurrentWeather(String city) async {
    try {
      var currentWeather = await api.loadCurrentWeather(city);
      weather.today = WeatherData.today(currentWeather);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadWeatherForecast(String city) async {
    try {
      var forecastWeather = await api.loadWeatherForecast(city);
      _processForecastData(forecastWeather);
    } catch (e) {
      print(e.toString());
    }
  }

  void _processForecastData(WeatherForecast forecast) {
    weather.tomorrow = WeatherData.fromForecast(
      forecast.list[0].weather[0],
      forecast.city,
      forecast.list[0].main.temp,
    );
    final forecastList = getForecastList(getForecastMap(forecast.list));
    weather.forecastList = forecastList;
    weather.forecastChartData = getForecastChartData(forecastList);
  }
}
