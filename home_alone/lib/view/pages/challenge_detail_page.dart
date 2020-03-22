import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/pages/login_page.dart';
import 'package:home_alone/view/widgets/label_text.dart';
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
      appBar: AppBar(title: Text('Challenge')),
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
          ThemedFlatButton(
              text: 'Share',
              onPressed: () {
                print('pressed');
                Share.share(
                    'Spiel mit mir die ${widget.challenge.name}. In der home alone challenge App.');
              }),
          _buildText(widget.challenge),
        ],
      );

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
    return _buildParticipateButton();
  }

  Widget _buildSlider() {
    return Container();
  }

  Widget _buildParticipateButton() => Padding(
        child: ThemedButton(text: 'Teilnehmen'),
        padding: EdgeInsets.all(16.0),
      );
}
