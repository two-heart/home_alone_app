import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/category_selection_store.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/categories/category_list.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/viewmodel/category_selection_model.dart';
import 'package:provider/provider.dart';

class CategorySelection extends StatefulWidget {
  @override
  _CategorySelectionState createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  @override
  void initState() {
    locator.get<CategorySelectionStore>().loadCategories();
    super.initState();
  }

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
          child: Builder(builder: (context) => _buildContent(context)),
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 8),
        _buildLabelText(),
        Expanded(child: _buildCategoryList(context)),
        _buildNextButton(context),
      ],
    );
  }

  Widget _buildCategoryList(BuildContext context) =>
      Provider.of<CategorySelectionModel>(context).isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CategoryList();

  Widget _buildLabelText() => ThemedText(
        text: 'Wofür interessierst du dich?',
        fontSize: HomeAloneDimensions.welcomeHeaderSmallerTextSize,
      );

  Widget _buildNextButton(BuildContext context) => ThemedButton(
        text: 'Weiter',
        onPressed:
            Provider.of<CategorySelectionModel>(context).actionButtonIsEnabled
                ? () => _sendCategorySelectionOpenHomePage(context)
                : null,
      );

  _sendCategorySelectionOpenHomePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
