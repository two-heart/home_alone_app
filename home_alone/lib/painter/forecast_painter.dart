import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_alone/model/forecast.dart';

class ForecastPainter extends CustomPainter {
  final Animation<double> animation;
  final Animation<int> elementsToAnimate;
  final ForecastChartData painterData;

  ForecastPainter({this.animation, this.elementsToAnimate, this.painterData})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final chartHeight = size.height;
    final chartWidth = size.width;

    final rect = Rect.fromLTRB(0, 0, chartWidth, chartHeight);

    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(rect, paint);

    canvas.drawLine(
        Offset(0, chartHeight / 2), Offset(chartWidth, chartHeight / 2), paint);

    paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    List<Offset> minTempPoints =
        _getPoints(painterData.normMinTemperatures, chartWidth, chartHeight);
    _drawLinesAndPoints(canvas, paint, minTempPoints, chartWidth, chartHeight);

    paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    List<Offset> maxTempPoints =
        _getPoints(painterData.normMaxTemperatures, chartWidth, chartHeight);
    _drawLinesAndPoints(canvas, paint, maxTempPoints, chartWidth, chartHeight);
  }

  void _drawLinesAndPoints(Canvas canvas, Paint paint, List<Offset> points,
      double chartWidth, double chartHeight) {
    Offset prev;
    for (Offset p in points) {
      if (prev != null) {
        canvas.drawLine(prev, p, paint);
      }
      prev = p;
      canvas.drawCircle(p, 3, paint);

      Paint gridPaint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.2;

      canvas.drawLine(Offset(0, p.dy), Offset(p.dx, p.dy), gridPaint);
      canvas.drawLine(Offset(p.dx, p.dy), Offset(chartWidth, p.dy), gridPaint);
      canvas.drawLine(Offset(p.dx, p.dy), Offset(p.dx, chartHeight), gridPaint);
      canvas.drawLine(Offset(p.dx, p.dy), Offset(p.dx, 0), gridPaint);
    }
  }

  List<Offset> _getPoints(
      List<ChartDataPoint> dataPoints, double chartWidth, double chartHeight) {
    List<Offset> points = List<Offset>();

    final zeroLevel = chartHeight / 2;

    for (int i = 0; i < elementsToAnimate.value; i++) {
      ChartDataPoint point = dataPoints[i];

      double xPoint = point.normalizedXValue * chartWidth;
      double yPoint = zeroLevel - point.normalizedYValue * zeroLevel;

      points.add(Offset(xPoint, yPoint));
    }
    return points;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
