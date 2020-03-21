import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/view/widgets/challenge/challenge_tile.dart';

class ChallengeSearchDelegate extends SearchDelegate {
  ChallengeApi api;

  ChallengeSearchDelegate(
    this.api, {
    searchFieldLabel,
    keyboardType,
    textInputAction = TextInputAction.search,
  }) : super(
            searchFieldLabel: searchFieldLabel,
            keyboardType: keyboardType,
            textInputAction: textInputAction);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: api.findChallenges(query),
      builder: (BuildContext context, AsyncSnapshot<List<Challenge>> value) =>
          value.connectionState == ConnectionState.done && !value.hasError
              ? ListView.builder(
                  itemCount: value.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final challenge = value.data[index];
                    return ChallengeTile(challenge, onTab: (tappedChallenge) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(tappedChallenge.name),
                              content: Text(tappedChallenge.description),
                              actions: <Widget>[
                                RaisedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                )
                              ],
                            );
                          });
                    });
                  })
              : Container(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
