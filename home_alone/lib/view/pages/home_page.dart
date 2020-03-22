import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/service/challenge_search_delegate.dart';
import 'package:home_alone/view/pages/dashboard_page.dart';
import 'package:home_alone/view/pages/settings_page.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'challenge_list_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    // final weatherStore = locator.get<WeatherStore>();
    // await weatherStore.loadWeatherForecast("Darmstadt");
    // await weatherStore.loadCurrentWeather("Darmstadt");
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    // var model = Provider.of<WeatherModel>(context);
    return DefaultTabController(
      length: _navigationItems.length,
      child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildContent(context),
          bottomNavigationBar: _buildTabBar(context)),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
  ) {
    return AppBar(
      title: Text("Home Alone"),
      actions: _buildSearchAction(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: TabBarView(children: [
        DashboardPage(),
        ChallengeListPage(),
        SettingsPage(),
      ]),
    );
  }

  Widget _buildTabBar(BuildContext context) => Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: TabBar(
          indicator: ShapeDecoration(
              shape: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                      style: BorderStyle.solid)),
              gradient: LinearGradient(
                colors: [
                  HomeAloneColors.primaryButtonGradientStartColor,
                  HomeAloneColors.primaryButtonGradientEndColor,
                ],
              )),
          unselectedLabelColor: Colors.white,
          labelColor: Theme.of(context).hintColor,
          tabs: _navigationItems,
        ),
      );

  final _navigationItems = <Widget>[
    Tab(icon: Icon(Icons.home), text: "Entdecken"),
    Tab(icon: Icon(Icons.queue), text: "Meine Challenges"),
    Tab(icon: Icon(Icons.settings), text: "Einstellungen"),
  ];

  List<Widget> _buildSearchAction(
    BuildContext context,
  ) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: ChallengeSearchDelegate(
              // model,
              locator.get<ChallengeApi>(),
              keyboardType: TextInputType.text,
              searchFieldLabel: "Name der Challenge ...",
            ),
          );
        },
      )
    ];
  }
}
