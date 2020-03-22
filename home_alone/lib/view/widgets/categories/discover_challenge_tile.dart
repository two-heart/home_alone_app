import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/view/pages/challenge_detail_page.dart';
import 'package:home_alone/view/theme/colors.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';

class DiscoverChallengeTile extends StatelessWidget {
  final Challenge challenge;
  final Function onChallengeAccepted;
  final bool fromAcceptedChallenges;

  DiscoverChallengeTile(this.challenge, this.onChallengeAccepted,
      {this.fromAcceptedChallenges = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDetailPage(context),
      child: _buildContent(context),
    );
  }

  Container _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: 350,
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildImageSection(),
            _buildTeaserText(),
            _buildButtonRow(context)
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      color: Color(0xF4F4F4),
      child: Stack(
        children: <Widget>[
          _buildImage(),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildTeaserText() => Padding(
        child: Container(
          width: double.infinity,
          child: Text(challenge.teaser,
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
              )),
        ),
        padding: EdgeInsets.only(left: 4.0),
      );

  Widget _buildButtonRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: fromAcceptedChallenges == true
            ? [
                Container(),
                challenge.finished
                    ? Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: CircleAvatar(
                            maxRadius: 18.0,
                            backgroundColor:
                                HomeAloneColors.primaryButtonGradientEndColor,
                            child: Image.asset(
                              "assets/image/check.png",
                              width: 24.0,
                            )),
                      )
                    : ThemedButton(
                        padding: 2,
                        text: "Zur Challenge",
                        width: 120,
                        onPressed: () {
                          _openDetailPage(context);
                        })
              ]
            : !challenge.accepted
                ? <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: ThemedFlatButton(
                        fontSize: 14,
                        text: "Zur Challenge",
                        onPressed: () {
                          _openDetailPage(context);
                        },
                      ),
                    ),
                    ThemedButton(
                        padding: 4,
                        text: "Teilnehmen",
                        width: 120,
                        onPressed: _acceptChallenge)
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: ThemedFlatButton(
                        fontSize: 14,
                        text: "Zur Challenge",
                        onPressed: () {
                          _openDetailPage(context);
                        },
                      ),
                    )
                  ],
      ),
    );
  }

  Positioned _buildText() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          width: double.infinity,
          color: Color(0x99000000),
          child: Text(
            challenge.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ));
  }

  Container _buildImage() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(
            URLS[challenge.id.hashCode.abs() % URLS.length],
          ),
        ),
      ),
    );
  }

  void _openDetailPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ChallengeDetail(challenge: challenge)),
    );
  }

  void _acceptChallenge() async {
    await locator.get<ChallengeApi>().acceptChallenge(challenge.id);
    onChallengeAccepted();
  }
}
