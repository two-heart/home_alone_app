import 'package:home_alone/model/weather.dart';
import 'package:home_alone/model/weather_forecast.dart';

class DayForecast {
  final String date;
  final List<SingleForecast> singleForecasts;

  DayForecast(this.date, this.singleForecasts);
}

class SingleForecast {
  final DateTime dateTime;
  final Weather weather;
  final Main main;

  SingleForecast(this.dateTime, this.weather, this.main);
}

class ForecastChartData {
  final List<ChartDataPoint> normMinTemperatures;
  final List<ChartDataPoint> normMaxTemperatures;

  ForecastChartData(this.normMinTemperatures, this.normMaxTemperatures);
}

class ChartDataPoint {
  final double yValue;
  final double normalizedYValue;
  final int dateTimeUnix;
  final double normalizedXValue;

  ChartDataPoint(this.yValue, this.normalizedYValue, this.dateTimeUnix,
      this.normalizedXValue);
}