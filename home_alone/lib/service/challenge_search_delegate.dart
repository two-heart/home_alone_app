import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/widgets/categories/discover_challenge_tile.dart';
import 'package:home_alone/view/widgets/challenge/challenge_tile.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/view/widgets/challenge/challenge_icon.dart';

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
      primaryColor: HomeAloneColors.primaryColor,
      primaryColorDark: HomeAloneColors.primaryDarkColor,
      primaryColorLight: HomeAloneColors.primaryLightColor,
      accentColor: HomeAloneColors.primaryLightColor,
      fontFamily: 'Baloo2',
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
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                child: CategoryIcon(
                                  maxRadius: 16,
                                  category: challenge.category,
                                ),
                                padding: EdgeInsets.only(left: 14.0),
                              ),
                              Padding(
                                child: ThemedText(
                                  fontSize: 16,
                                  text: challenge.category.name,
                                  textAlign: TextAlign.left,
                                ),
                                padding: EdgeInsets.only(left: 8),
                              )
                            ],
                          ),
                        ),
                        DiscoverChallengeTile(challenge, () {
                          locator
                              .get<ChallengeApi>()
                              .acceptChallenge(challenge.id);
                        })
                      ],
                    );
                  })
              : Container(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
