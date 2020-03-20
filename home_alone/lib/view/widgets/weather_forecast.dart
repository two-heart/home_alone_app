import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:home_alone/model/forecast.dart';

class WeatherForecast extends StatelessWidget {
  final List<DayForecast> forecastList;

  WeatherForecast(this.forecastList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: forecastList.length,
        itemBuilder: (context, i) {
          final day = forecastList[i];
          final dateTime = DateTime.parse(day.date);
          final dayName = DateFormat('EEEE').format(dateTime);
          return new ExpansionTile(
            title: new Text("${day.date} $dayName"),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(day.singleForecasts),
              ),
            ],
          );
        },
      );
  }
}

_buildExpandableContent(List<SingleForecast> list) {
  List<Widget> columnContent = [];

  for (SingleForecast singleForecast in list) {
    String time =
        "${singleForecast.dateTime.hour.toString().padLeft(2, '0')}:${singleForecast.dateTime.minute.toString().padLeft(2, '0')}";
    columnContent.add(
      new ListTile(
        title: new Text(time),
        subtitle: new Text(singleForecast.weather.main),
      ),
    );
  }

  return columnContent;
}
