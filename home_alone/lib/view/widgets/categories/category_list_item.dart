import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/widgets/challenge/challenge_icon.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/viewmodel/category_model.dart';
import 'package:provider/provider.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: <Widget>[
            _buildCategoryIcon(),
            SizedBox(width: 8),
            _buildCategoryName(),
            Expanded(child: Container()),
            _buildCheckBox(),
          ],
        ),
      );

  Widget _buildCheckBox() => ChangeNotifierProvider.value(
        value: category,
        child: Consumer<CategoryModel>(
          builder: (context, model, _) => Switch(
            activeColor: HomeAloneColors.categoryIconColor,
            value: model.isSelected,
            onChanged: (value) => model.isSelected = value,
          ),
        ),
      );

  Widget _buildCategoryName() => LabelText(
        text: category.category.name,
        fontWeight: FontWeight.bold,
        color: HomeAloneColors.categoryIconColor,
      );

  Widget _buildCategoryIcon() => CategoryIcon(category: category.category);

  //  CircleAvatar(
  //       backgroundColor: HomeAloneColors.categoryIconColor,
  //       child: Icon(
  //         Icons.shopping_cart,
  //         color: Colors.white,
  //       ),
  //     );
}
