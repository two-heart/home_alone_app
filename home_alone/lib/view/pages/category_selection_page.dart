
import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/categories/category_list.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/viewmodel/category_selection_model.dart';
import 'package:provider/provider.dart';

class CategorySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Home Alone')),
        body: _buildBody(context),
      );

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ChangeNotifierProvider.value(
          value: locator.get<CategorySelectionModel>(),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 8),
        _buildLabelText(),
        Expanded(child: CategoryList()),
        _buildNextButton(context),
      ],
    );
  }

  Widget _buildLabelText() => ThemedText(
        text: 'Wofür interessierst du dich?',
        fontSize: HomeAloneDimensions.welcomeHeaderSmallerTextSize,
      );

  Widget _buildNextButton(BuildContext context) => ThemedButton(
        text: 'Weiter',
        onPressed: _sendCategorySelectionOpenHomePage(context),
      );

  _sendCategorySelectionOpenHomePage(BuildContext context) {

  }
}
