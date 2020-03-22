import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/pages/challenge_detail_page.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';

class DiscoverChallengeTile extends StatelessWidget {
  final Challenge challenge;

  DiscoverChallengeTile(this.challenge);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDetailPage(context),
      child: _buildContent(),
    );
  }

  Container _buildContent() {
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
            _buildButtonRow()
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

  Widget _buildButtonRow() {
    return Padding(
      padding: EdgeInsets.only(
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: !challenge.accepted
            ? <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: ThemedFlatButton(
                    fontSize: 14,
                    text: "Zur Challenge",
                    onPressed: () {},
                  ),
                ),
                ThemedButton(
                    padding: 4,
                    text: "Teilnehmen",
                    width: 120,
                    onPressed: _acceptChallenge)
              ]
            : [],
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
            "https://www.meridianspa.de/fileadmin/user_upload/Fitness-Hamburg-Meridian-Plank.jpg",
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

  void _acceptChallenge() {}
}
