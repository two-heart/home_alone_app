import 'package:flutter/material.dart';
import 'package:home_alone/view/widgets/label_text.dart';
import 'package:home_alone/view/widgets/themed_app_bar.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:home_alone/view/widgets/themed_flat_button.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:home_alone/view/widgets/weird/weird_ball.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTexts(context),
            _buildRegisterButton(context),
            _buildLoginButton(context),
          ],
        ),
      ).withWeirdBall(),
    );
  }

  Widget _buildTexts(BuildContext context) => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildWelcomeText(context),
            SizedBox(height: 30),
            _buildWelcomeExplanation(context),
          ],
        ),
      );

  Widget _buildWelcomeText(BuildContext context) => Column(
        children: <Widget>[
          ThemedText(text: 'Willkommen bei'),
          ThemedText(text: "Home Alone!")
        ],
      );

  Widget _buildWelcomeExplanation(BuildContext context) => LabelText(
      text:
          'Hier erwarten dich spannende Challanges, mit denen du deine Quarantänezeit aufpeppen und dich selbst herausfordern kannst.');

  Widget _buildRegisterButton(BuildContext context) => ThemedButton(
        text: 'Registrieren',
        onPressed: () =>
            Navigator.of(context).pushNamed("/register/setUsername"),
      );

  Widget _buildLoginButton(BuildContext context) => ThemedFlatButton(
        text: 'Einloggen',
        onPressed: () => Navigator.of(context).pushNamed("/login"),
      );

  AppBar _buildAppBar() {
    return ThemedAppBar(showLogo: true);
  }
}

// just as a placeholder... to make it look like the mock
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
