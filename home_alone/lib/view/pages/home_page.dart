import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/service/city_search_delegate.dart';
import 'package:home_alone/view/pages/login_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  AppBar _buildAppBar(BuildContext context,) {
    return AppBar(
      title: Text("Tolle Appbar"),
      actions: _buildSearchAction(context),
    );
  }

  SmartRefresher _buildContent(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: TabBarView(children: [
        LoginPage(),
        LoginPage(),
        LoginPage(),
      ]),
    );
  }

  Widget _buildTabBar(BuildContext context) => Container(
        color: Theme.of(context).accentColor,
        child: TabBar(
          indicatorColor: Colors.orange,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.orange,
          tabs: _navigationItems,
        ),
      );

  final _navigationItems = <Widget>[
    Tab(icon: Icon(Icons.cloud), text: "Login"),
    Tab(icon: Icon(Icons.cloud), text: "Noch mal Login"),
    Tab(icon: Icon(Icons.cloud), text: "Ändere mich!"),
  ];

  List<Widget> _buildSearchAction(BuildContext context, ) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // showSearch(
          //   context: context,
          //   delegate: CitySearchDelegate(
          //     // model,
          //     null,
          //     locator.get<OpenWeatherApi>(),
          //     keyboardType: TextInputType.text,
          //     searchFieldLabel: "City ...",
          //   ),
          // );
        },
      )
    ];
  }
}
