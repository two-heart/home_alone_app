import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';

class ChallengeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    Challenge challenge = ModalRoute.of(context).settings.arguments;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImage('assets/something.jpg', context),
          ..._buildText(challenge),
          Expanded(child: Container()),
          _buildSlider(context, 0)
        ]);
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Challenge'),
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

  List<Widget> _buildText(Challenge challenge) {
    return [ThemedText(text: challenge.name), Text(challenge.description)];
  }

  Widget _buildSlider(BuildContext context, _value) {
    // TODO actual Slider and action
    return ThemedButton(text: 'Teilnehmen');
  }
}
