import 'package:flutter/material.dart';

class CurvedAppBarBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {

    final size = rect.size;
    Path path = Path();
    path.lineTo(0, size.height - 5);
    path.quadraticBezierTo(
        size.width / 2, size.height + 3, size.width, size.height - 5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
}