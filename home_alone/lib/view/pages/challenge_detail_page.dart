import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/pages/login_page.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';

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
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          _buildImage('assets/something.jpg', context),
          _buildText(widget.challenge),
          _buildSlider(context, 0),
        ]),
      ),
    );
  }

  Widget _buildImage(String path, BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 200.0),
        // placeholder if image load fails
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
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

  Widget _buildSlider(BuildContext context, _value) {
    // TODO actual Slider and action
    return Padding(
      child: ThemedButton(text: 'Teilnehmen'),
      padding: EdgeInsets.all(16.0),
    );
  }
}
