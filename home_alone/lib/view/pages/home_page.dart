import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/service/city_search_delegate.dart';
import 'package:home_alone/service/open_weather_api.dart';
import 'package:home_alone/store/weather_store.dart';
import 'package:home_alone/view/widgets/weather_content.dart';
import 'package:home_alone/view/widgets/weather_forecast.dart';
import 'package:home_alone/view/widgets/weather_forecast_chart.dart';
import 'package:home_alone/viewmodel/weather_model.dart';
import 'package:provider/provider.dart';
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
    final weatherStore = locator.get<WeatherStore>();
    await weatherStore.loadWeatherForecast("Darmstadt");
    await weatherStore.loadCurrentWeather("Darmstadt");
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<WeatherModel>(context);
    return DefaultTabController(
      length: _navigationItems.length,
      child: Scaffold(
          appBar: _buildAppBar(context, model),
          body: _buildContent(model, context),
          bottomNavigationBar: _buildTabBar(context)),
    );
  }

  AppBar _buildAppBar(BuildContext context, WeatherModel model) {
    return AppBar(
      title: Text(title),
      actions: _buildSearchAction(context, model),
    );
  }

  SmartRefresher _buildContent(WeatherModel model, BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: TabBarView(children: [
        WeatherContent(weather: Provider.of<WeatherModel>(context).today),
        WeatherContent(weather: Provider.of<WeatherModel>(context).tomorrow),
        WeatherForecast(Provider.of<WeatherModel>(context).forecastList),
        WeatherForecastChart(Provider.of<WeatherModel>(context).forecastChartData),
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
    Tab(icon: Icon(Icons.cloud), text: "Current"),
    Tab(icon: Icon(Icons.cloud), text: "Tomorrow"),
    Tab(icon: Icon(Icons.cloud), text: "Forecast"),
    Tab(icon: Icon(Icons.cloud), text: "Chart"),
  ];

  List<Widget> _buildSearchAction(BuildContext context, WeatherModel model) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: CitySearchDelegate(
              model,
              locator.get<OpenWeatherApi>(),
              keyboardType: TextInputType.text,
              searchFieldLabel: "City ...",
            ),
          );
        },
      )
    ];
  }
}
