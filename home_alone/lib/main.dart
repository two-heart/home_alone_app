import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:home_alone/view/pages/home_page.dart';
import 'package:home_alone/view/pages/login_page.dart';
import 'package:home_alone/view/pages/welcome_page.dart';

import 'package:provider/provider.dart';

import 'package:home_alone/dependency_injection/dependency_injection.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  // debugPrintHitTestResults = true;
  // debugPaintPointersEnabled = true;

  await DependencyInjection.setUp();
  DependencyInjection.loadWeather();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider.value(
        //   value: locator.get<WeatherModel>(),
        //   child:
        RefreshConfiguration(
      headerBuilder: () =>
          WaterDropMaterialHeader(), // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
      footerBuilder: () =>
          ClassicFooter(), // Configure default bottom indicator
      headerTriggerDistance: 80.0, // header trigger refresh trigger distance
      springDescription: SpringDescription(
          stiffness: 170,
          damping: 16,
          mass:
              1.9), // custom spring back animate,the props meaning see the flutter api
      maxOverScrollExtent:
          100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
      maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted:
          true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed:
          true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull:
          false, // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
          '/app': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        },
        // ),
      ),
    );
  }
}
