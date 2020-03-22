import 'package:flutter/material.dart';
import 'package:home_alone/model/category.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/theme/colors.dart';

class CategoryIcon extends StatelessWidget {
  final Category category;

  const CategoryIcon({
    Key key,
    this.category,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => CircleAvatar(
        maxRadius: 22,
        backgroundColor: HomeAloneColors.primaryButtonGradientEndColor,
        child: Image.asset(
          _getImagePath(category.name.toLowerCase()),
          // color: Colors.green,
        ),
      );

  String _getImagePath(String category) =>
      'assets/image/category/$category.png';
}
