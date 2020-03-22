import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/store/category_selection_store.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/categories/category_list.dart';
import 'package:home_alone/view/widgets/themed_app_bar.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/viewmodel/category_selection_model.dart';
import 'package:provider/provider.dart';

class CategorySelection extends StatefulWidget {
  final bool fromSettings;
  CategorySelection({@required this.fromSettings});

  @override
  _CategorySelectionState createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  @override
  void initState() {
    locator.get<CategorySelectionStore>().loadCategories();
    locator.get<CategorySelectionStore>().loadSelectedCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: ThemedAppBar(
          title: 'Kategorien',
        ),
        body: _buildBody(context),
      );

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: Center(
        child: ChangeNotifierProvider.value(
          value: locator.get<CategorySelectionModel>(),
          child: Builder(builder: (context) => _buildContent(context)),
        ),
      ),
    ));
  }

  Column _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 8),
        _buildTextAndList(context),
        _buildNextButton(context),
      ],
    );
  }

  _buildTextAndList(BuildContext context) => Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLabelText(),
              SizedBox(height: 8),
              _buildCategoryList(context),
            ],
          ),
        ),
      );

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

  Widget _buildNextButton(BuildContext context) {
    var onPressed;
    var model = Provider.of<CategorySelectionModel>(context);
    print(widget.fromSettings);
    if (widget.fromSettings) {
      onPressed = () async {
        await _sendCategorySelectionOpenHomePage(context);
        Navigator.of(context).pop();
      };
    } else if (model.actionButtonIsEnabled) {
      onPressed = () async {
        await _sendCategorySelectionOpenHomePage(context);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      };
    }

    return ThemedButton(
      text: widget.fromSettings ? 'Speichern' : 'Weiter',
      onPressed: onPressed,
    );
  }

  _sendCategorySelectionOpenHomePage(BuildContext context) async {
    await locator.get<CategorySelectionStore>().updateCategories();
  }
}
