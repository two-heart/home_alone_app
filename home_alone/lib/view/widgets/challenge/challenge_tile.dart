import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';

class ChallengeTile extends StatelessWidget {
  final Challenge challenge;
  ChallengeTile(this.challenge,
      {Function onTab, Null Function(tappedChallenge)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Material(
            elevation: 4.0,
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              onTap: () {
                Navigator.pushNamed(context, 'challenge', arguments: challenge);
              },
              title: Text(
                challenge.name,
                style: TextStyle(color: Colors.black87, fontSize: 24),
              ),
              subtitle: Text(
                challenge.description,
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      padding: EdgeInsets.all(8),
    );
  }
}
