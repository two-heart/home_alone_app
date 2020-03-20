import 'package:flutter/material.dart';
import 'package:home_alone/viewmodel/weather_data.dart';

class WeatherContent extends StatelessWidget {
  const WeatherContent({
    Key key,
    @required this.weather,
  }) : super(key: key);

  final WeatherData weather;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: (weather == null)
            ? [CircularProgressIndicator()]
            : _buildContent(context),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) => [
        _buildCityNameText(),
        SizedBox(height: 8),
        _buildWeatherImage(context),
        SizedBox(height: 8),
        _buildTemperatureText(context),
        SizedBox(height: 8),
        _buildDescriptionText(),
      ];

  Text _buildCityNameText() => Text(
        weather.city,
        style: TextStyle(fontSize: 20.0),
      );

  Text _buildTemperatureText(BuildContext context) => Text(
        weather.temperature,
        style: Theme.of(context).textTheme.display1,
      );

  Text _buildDescriptionText() => Text(
        weather.description,
        style: TextStyle(fontSize: 20.0),
      );

  GestureDetector _buildWeatherImage(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetailDialogOrSomethingIDunno(context),
      child: Image(image: NetworkImage(weather.iconUrl)),
    );
  }

  _openDetailDialogOrSomethingIDunno(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Title"),
        content: Text("Message"),
      ),
    );
  }
}
