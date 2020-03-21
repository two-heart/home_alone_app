import 'package:flutter/material.dart';
import 'package:home_alone/viewmodel/category_model.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          _buildInformation(),
          _buildCheckBox(),
        ],
      );

  Widget _buildCheckBox() => Checkbox(
        value: category.isSelected,
        onChanged: null,
      );

  _buildInformation() {}
}
