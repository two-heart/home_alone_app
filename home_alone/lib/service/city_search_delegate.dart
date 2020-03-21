// import 'package:flutter/material.dart';
// import 'package:home_alone/model/current_weather.dart';
// import 'package:home_alone/service/open_weather_api.dart';
// import 'package:home_alone/viewmodel/weather_data.dart';
// import 'package:home_alone/viewmodel/weather_model.dart';

// class CitySearchDelegate extends SearchDelegate {
//   // WeatherModel model;
//   OpenWeatherApi api;

//   CitySearchDelegate(
//     this.model,
//     this.api, {
//     searchFieldLabel,
//     keyboardType,
//     textInputAction = TextInputAction.search,
//   }) : super(
//             searchFieldLabel: searchFieldLabel,
//             keyboardType: keyboardType,
//             textInputAction: textInputAction);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       tooltip: 'Back',
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return FutureBuilder(
//       future: api.loadCurrentWeather(query),
//       builder: (BuildContext context, AsyncSnapshot<CurrentWeather> value) =>
//           value.hasData
//               ? ListView(
//                   children: []..add(FlatButton(
//                       child: Text(value.data.name),
//                       onPressed: () {
//                         model.today = WeatherData.today(value.data);
//                         close(context, true);
//                       })))
//               : Container(),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Container();
//   }
// }
