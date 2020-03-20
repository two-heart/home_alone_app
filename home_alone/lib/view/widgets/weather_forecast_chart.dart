import 'package:flutter/material.dart';
import 'package:home_alone/model/forecast.dart';
import 'package:home_alone/utils/painter/forecast_painter.dart';

class WeatherForecastChart extends StatefulWidget {
  final ForecastChartData forecastChartData;

  WeatherForecastChart(this.forecastChartData);

  @override
  _WeatherForecastChartState createState() => _WeatherForecastChartState();
}

class _WeatherForecastChartState extends State<WeatherForecastChart>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> elementsToAnimate;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    elementsToAnimate = IntTween(
      begin: 0,
      end: widget.forecastChartData.normMinTemperatures.length,
    ).animate(_controller);

    const double chartPadding = 8.0;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double chartHeight = screenHeight / 2;
    final double chartWidth = screenWidth - chartPadding * 2;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(chartPadding),
        child: new CustomPaint(
          size: Size(chartWidth, chartHeight),
          foregroundPainter: new ForecastPainter(
            animation: _controller,
            elementsToAnimate: elementsToAnimate,
            painterData: widget.forecastChartData,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _startAnimation,
        child: new Icon(Icons.play_arrow),
      ),
    );
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.forward();
  }
}
