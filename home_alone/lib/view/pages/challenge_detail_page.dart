import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/view/pages/login_page.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_app_bar.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';
import 'package:share/share.dart';

const URLS = [
  "https://www.stendo.net/mobile/img/senior/senior-13.jpg",
  "https://www.meridianspa.de/fileadmin/user_upload/Fitness-Hamburg-Meridian-Plank.jpg"
];

class ChallengeDetail extends StatefulWidget {
  final Challenge challenge;

  const ChallengeDetail({this.challenge});

  @override
  _ChallengeDetailState createState() => _ChallengeDetailState();
}

class _ChallengeDetailState extends State<ChallengeDetail>
    with AwfulKeyboardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ThemedAppBar(title: widget.challenge.name),
      body: _buildBody(context).withAwfulKeyboardFix(this),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(child: _buildContent(context)),
        _buildButtonOrSlider(context),
      ]),
    );
  }

  Widget _buildContent(BuildContext context) => ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildImage(widget.challenge, context),
          _buildShareButton(),
          _buildText(widget.challenge),
        ],
      );

  Widget _buildShareButton() {
    return ThemedFlatButton(
        text: 'Share',
        onPressed: () {
          Share.share(
              'Spiel mit mir die ${widget.challenge.name}. In der home alone challenge App.');
        });
  }

  Widget _buildImage(Challenge challenge, BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 200.0),
        // placeholder if image load fails
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Image(
            image:
                NetworkImage(URLS[challenge.id.hashCode.abs() % URLS.length]),
          ),
        ));
  }

  Widget _buildText(Challenge challenge) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        SizedBox(height: 10),
        ThemedText(text: challenge.name),
        LabelText(
          text: challenge.description,
          textAlign: TextAlign.start,
        ),
      ]),
    );
  }

  Widget _buildButtonOrSlider(BuildContext context) {
    if (widget.challenge.finished) {
      return Container();
    }
    if (widget.challenge.accepted == true) {
      return _buildSlider();
    }
    return _buildAcceptChallengeButton();
  }

  Widget _buildSlider() => Padding(
        child: ThemedButton(
          text: 'Challenge abschießen',
          onPressed: _finishChallenge,
        ),
        padding: EdgeInsets.all(16.0),
      );

  Widget _buildAcceptChallengeButton() => Padding(
        child: ThemedButton(
          text: 'Teilnehmen',
          onPressed: _acceptChallenge,
        ),
        padding: EdgeInsets.all(16.0),
      );

  void _acceptChallenge() {
    locator.get<ChallengeApi>().acceptChallenge(widget.challenge.id);
  }

  Widget _buildFinishedPopup(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(
                'assets/challenge_accomplished_face.png',
                width: 200.0,
                fit: BoxFit.cover,
              ),
              Padding(
                child: ThemedText(
                  fontSize: 22.0,
                  text: 'Super du hast die Challenge erledigt!',
                ),
                padding: EdgeInsets.only(top: 8, bottom: 8),
              ),
              Text(
                'Du hast die Challenge ${widget.challenge.name} abgeschlossen.',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: ThemedButton(
                  text: 'Weiter',
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              )
            ],
          ),
        ));
  }

  _finishChallenge() async {
    await locator.get<ChallengeApi>().finishChallenge(widget.challenge.id);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildFinishedPopup(context);
        });
  }
}
