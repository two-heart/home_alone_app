import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_alone/view/pages/login_page.dart';
import 'package:home_alone/view/theme/dime.dart';

class WeirdBall extends StatelessWidget {
  final bool inHero;
  const WeirdBall({
    this.inHero = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var container = Container(
        width: HomeAloneDimensions.circularLogoSize,
        height: HomeAloneDimensions.circularLogoSize,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              transform: GradientRotation(90 * pi / 180.0),
              colors: [
                Color(0xFFD2FCC6),
                Color(0xFF00BF91),
              ],
            ),
            borderRadius: BorderRadius.circular(
                HomeAloneDimensions.circularLogoSize / 2.0)));

    if (inHero) {
      return container;
    }

    return Positioned(
        left: HomeAloneDimensions.circularLogoMargin,
        top: HomeAloneDimensions.circularLogoMargin,
        child: container);
  }
}

typedef ParentWidgetBuilder = Widget Function(Widget child);

extension WeirdBallExtension on Widget {
  Widget withWeirdBall({ParentWidgetBuilder builder}) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          // left: 16,
          top: 16,
          child: Hero(
            // child: WeirdBall(inHero: true),
            child: _buildIcon(),
            tag: "WEIRD_BALL",
          ),
        ),
        builder != null ? builder(this) : this
      ],
    );
  }

  Widget _buildIcon() => Image.asset('assets/hamster.png',
      height: HomeAloneDimensions.circularLogoSize * 3);
}

extension AwfulKeyboardFix on Widget {
  Widget withAwfulKeyboardFix(AwfulKeyboardMixin mixin,
      {ParentWidgetBuilder builder}) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          child: Container(
              height: mixin.getContentHeightForAwfulKeyboard(constraints),
              child: this));
    });
  }
}
