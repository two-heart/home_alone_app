import 'package:flutter/material.dart';
import 'package:home_alone/model/category.dart';
import 'package:home_alone/view/theme/colors.dart';

class CategoryIcon extends StatelessWidget {
  final Category category;
  final double maxRadius;

  const CategoryIcon({
    Key key,
    this.maxRadius = 22,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CircleAvatar(
        maxRadius: maxRadius,
        backgroundColor: HomeAloneColors.primaryButtonGradientEndColor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            _getImagePath(category.name.toLowerCase()),
            // color: Colors.green,
          ),
        ),
      );

  String _getImagePath(String category) =>
      'assets/image/categories/$category.png';
}
