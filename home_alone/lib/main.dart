import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:home_alone/view/pages/home_page.dart';
import 'package:home_alone/view/pages/login_page.dart';

import 'package:provider/provider.dart';

import 'package:home_alone/dependency_injection/dependency_injection.dart';
import 'package:home_alone/dependency_injection/locator.dart';

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
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => LoginPage(),
          '/app': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        },
      // ),
    );
  }
}
