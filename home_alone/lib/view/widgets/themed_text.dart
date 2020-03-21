import 'package:flutter/material.dart';

class ThemedText extends StatelessWidget {
  final String text;

  const ThemedText({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.display2,
      );
}
