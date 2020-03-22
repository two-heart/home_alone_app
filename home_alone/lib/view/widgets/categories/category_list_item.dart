import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/category_selection_store.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/widgets/challenge/challenge_icon.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/viewmodel/category_model.dart';
import 'package:provider/provider.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    this.category,
    this.fromSettings,
  });

  final CategoryModel category;
  final bool fromSettings;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: <Widget>[
            CategoryIcon(category: category.category),
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
            onChanged: (value) => _onCategorySelectionToggled(model, value),
          ),
        ),
      );

  void _onCategorySelectionToggled(CategoryModel model, bool value) {
    model.isSelected = value;
    if (fromSettings) {
      locator.get<CategorySelectionStore>().updateCategories();
    }
  }

  Widget _buildCategoryName() => LabelText(
        text: category.category.name,
        fontWeight: FontWeight.bold,
        color: HomeAloneColors.categoryIconColor,
      );
}
