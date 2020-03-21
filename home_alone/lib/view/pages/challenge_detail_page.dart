import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';

class ChallengeDetail extends StatelessWidget {
  final Challenge challenge;

  const ChallengeDetail({this.challenge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Challenge')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        _buildImage('assets/something.jpg', context),
        _buildText(challenge),
        Expanded(child: Container()),
        _buildSlider(context, 0),
      ]),
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
        LabelText(text: challenge.description, textAlign: TextAlign.start,),
      ]),
    );
  }

  Widget _buildSlider(BuildContext context, _value) {
    // TODO actual Slider and action
    return ThemedButton(text: 'Teilnehmen');
  }
}
