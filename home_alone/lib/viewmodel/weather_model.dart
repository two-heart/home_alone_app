import 'package:flutter/material.dart';
import 'package:home_alone/model/forecast.dart';
import 'package:home_alone/viewmodel/weather_data.dart';

class WeatherModel with ChangeNotifier {
  WeatherData _today;
  WeatherData _tomorrow;

  WeatherData get today => _today;
  WeatherData get tomorrow => _tomorrow;

  set today(WeatherData value) {
    _today = value;
    notifyListeners();
  }

  set tomorrow(WeatherData value) {
    _tomorrow = value;
    notifyListeners();
  }

  var _forecastList = List<DayForecast>();
  get forecastList => _forecastList;
  set forecastList(List<DayForecast> list) {
    _forecastList = list;
    notifyListeners();
  }

  var _forecastChartData = ForecastChartData(null, null);
  get forecastChartData => _forecastChartData;
  set forecastChartData(ForecastChartData chartData) {
    _forecastChartData = chartData;
    notifyListeners();
  }
}
