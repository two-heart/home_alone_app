import 'dart:math';

import 'package:home_alone/model/forecast.dart';
import 'package:home_alone/model/weather_forecast.dart';

Map<String, List<SingleForecast>> getForecastMap(List<ForecastList> list) {
  Map<String, List<SingleForecast>> map = Map<String, List<SingleForecast>>();
  for (ForecastList item in list) {
    DateTime dateTime = _parseTimestamp(item.dt);
    String key =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    if (!map.containsKey(key)) {
      List<SingleForecast> dayForecasts = List<SingleForecast>();
      dayForecasts.add(SingleForecast(dateTime, item.weather[0], item.main));
      map.putIfAbsent(key, () => dayForecasts);
    } else {
      List<SingleForecast> dayForecasts = map[key];
      dayForecasts.add(SingleForecast(dateTime, item.weather[0], item.main));
      map.putIfAbsent(key, () => dayForecasts);
    }
  }
  return map;
}

List<DayForecast> getForecastList(Map<String, List<SingleForecast>> map) {
  List<DayForecast> list = List<DayForecast>();
  for (String key in map.keys.toList()..sort()) {
    list.add(DayForecast(key, map[key]));
  }
  return list;
}

ForecastChartData getForecastChartData(List<DayForecast> list) {
  List<ChartDataPoint> minTemperatures = List<ChartDataPoint>();
  List<ChartDataPoint> maxTemperatures = List<ChartDataPoint>();

  List<double> yValues = List<double>();
  List<int> xValues = List<int>();

  for (DayForecast dayForecast in list) {
    for (SingleForecast singleForecast in dayForecast.singleForecasts) {
      double tempMin = singleForecast.main.temp_min;
      double tempMax = singleForecast.main.temp_max;
      int dateTimeUnix = singleForecast.dateTime.microsecondsSinceEpoch;
      yValues.add(tempMin);
      yValues.add(tempMax);
      xValues.add(dateTimeUnix);
      minTemperatures.add(ChartDataPoint(tempMin, null, dateTimeUnix, null));
      maxTemperatures.add(ChartDataPoint(tempMax, null, dateTimeUnix, null));
    }
  }

  double yMax = yValues.reduce((curr, next) => max(curr, next));
  double yMin = yValues.reduce((curr, next) => min(curr, next));
  int xMax = xValues.reduce((curr, next) => max(curr, next));
  int xMin = xValues.reduce((curr, next) => min(curr, next));

  return ForecastChartData(
      normalizeChartDataList(minTemperatures, yMin, yMax, xMax, xMin),
      normalizeChartDataList(maxTemperatures, yMin, yMax, xMax, xMin));
}

List<ChartDataPoint> normalizeChartDataList(
    List<ChartDataPoint> list, double yMin, double yMax, int xMax, int xMin) {
  List<ChartDataPoint> normalizedList = List<ChartDataPoint>();
  int xRange = xMax - xMin;
  for (ChartDataPoint dataPoint in list) {
    double yNorm = dataPoint.yValue / yMax;
    int xDiff = dataPoint.dateTimeUnix - xMin;
    double xNorm = xDiff / xRange;
    normalizedList.add(
        ChartDataPoint(dataPoint.yValue, yNorm, dataPoint.dateTimeUnix, xNorm));
  }
  return normalizedList;
}

DateTime _parseTimestamp(int timestamp) {
  return new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toUtc();
}
