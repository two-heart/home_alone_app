import 'package:flutter/material.dart';
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
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImage('assets/something.jpg', context),
          ..._buildText(),
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

  List<Widget> _buildText() {
    return [
      ThemedText(text: 'Challenge Name'),
      Text('Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.')
    ];
  }

  Widget _buildSlider(BuildContext context, _value) {
    return ThemedButton(text: 'Teilnehmen');
  }
}