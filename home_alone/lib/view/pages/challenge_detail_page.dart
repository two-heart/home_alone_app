import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/service/challenge/http_challenge_api.dart';
import 'package:home_alone/view/pages/login_page.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_app_bar.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';
import 'package:share/share.dart';

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
      appBar: ThemedAppBar(title: 'Challenge'),
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
          ThemedButton(
              text: 'test',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildFinishedPopup(context);
                    });
              }),
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
            image: NetworkImage(challenge.imageUrl),
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
    print(widget.challenge != null);
    if (widget.challenge.accepted == true) {
      return _buildSlider();
    }
    return _buildAcceptChallengeButton();
  }

  Widget _buildSlider() {
    return Container();
  }

  Widget _buildAcceptChallengeButton() => Padding(
        child: ThemedButton(
          text: 'Teilnehmen',
          onPressed: _acceptChallenge,
        ),
        padding: EdgeInsets.all(16.0),
      );

  void _acceptChallenge() {
    // await locator.get<HttpChallengeApi>().acceptChallenge(widget.challenge.id);
    locator.get<ChallengeApi>().acceptChallenge(widget.challenge.id);
  }

  Widget _buildFinishedPopup(BuildContext context) {
    return AlertDialog(
        content: Column(
      children: <Widget>[
        new Image.asset(
          'assets/hamster.png',
          width: 400.0,
          fit: BoxFit.cover,
        ),
        Text(
            'Herzlichen Glückwunsch du hast die Challenge ${widget.challenge.name} abgeschlossen.'),
        ThemedButton(
          text: 'Weiter',
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        )
      ],
    ));
  }
}
