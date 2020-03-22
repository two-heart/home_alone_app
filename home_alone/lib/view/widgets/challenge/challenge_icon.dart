import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';

class CategoryIcon extends StatelessWidget {
  final Challenge challenge;

  const CategoryIcon({
    Key key,
    this.challenge,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => CircleAvatar(
        foregroundColor: Colors.green,
        maxRadius: 50,
        child:
            Image.asset(_getImagePath(challenge.category.name.toLowerCase())),
      );

  String _getImagePath(String category) =>
      'assets/image/categories/$category.png';
}
