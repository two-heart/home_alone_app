import 'package:flutter/cupertino.dart';

import 'package:home_alone/model/current_weather.dart';
import 'package:home_alone/model/weather.dart';
import 'package:home_alone/model/weather_forecast.dart';

class WeatherData {
  String temperature;
  String description;
  String iconUrl;
  String city;
  String longitude;
  String latitude;

  WeatherData({
    @required this.temperature,
    @required this.description,
    @required this.iconUrl,
    @required this.city,
    @required this.longitude,
    @required this.latitude,
  });

  factory WeatherData.today(CurrentWeather weather) {
    return WeatherData(
      temperature: weather.main.temp._toTemperatureString(),
      longitude: weather.coord.lon._toLatLonString(),
      latitude: weather.coord.lat._toLatLonString(),
      description: weather.weather[0].main,
      iconUrl: _getIconUrl(weather.weather[0].icon),
      city: weather.name,
    );
  }

  factory WeatherData.fromForecast(
    Weather weather,
    City city,
    double temperature,
  ) {
    return WeatherData(
      temperature: temperature._toTemperatureString(),
      description: weather.main,
      iconUrl: _getIconUrl(weather.icon),
      city: city.name,
      longitude: city.coord.lon._toLatLonString(),
      latitude: city.coord.lat._toLatLonString(),
    );
  }

  static String _getIconUrl(String icon) =>
      "http://openweathermap.org/img/wn/${icon}@2x.png";
}

extension on double {
  //FIX this name... please
  String _toLatLonString() =>
      this == null ? "X.XX" : "${this.toStringAsFixed(2)}";

  String _toTemperatureString() =>
      this == null || this.isNaN ? "- °C" : "${this.toStringAsFixed(2)} °C";
}
