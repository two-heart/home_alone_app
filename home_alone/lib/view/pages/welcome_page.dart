import 'package:flutter/material.dart';
import 'package:home_alone/view/theme/dime.dart';
import 'package:home_alone/view/widgets/label_text.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTexts(context),
          _buildRegisterButton(),
          _buildLoginButton(),
        ],
      ),
    ).withWeirdBall();
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
          'Hier erwarten dich spannende Challanges, mit denen du deine Quarantänezeit aufpeppen un dich selbst herausfordern kannst');

  Widget _buildLoginButton() => LayoutBuilder(
        builder: (context, constraints) => ThemedFlatButton(
            text: 'Einloggen',
            onPressed: () => Navigator.of(context).pushNamed("/login")),
      );

  Widget _buildRegisterButton() => LayoutBuilder(
        builder: (context, constraints) => ThemedButton(
          onPressed: () =>
              Navigator.of(context).pushNamed("/register/setUsername"),
          text: 'Registieren',
        ),
      );

  AppBar _buildAppBar() {
    return AppBar(title: Text('App Logo'));
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
