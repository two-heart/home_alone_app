import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';

class ChallengeTile extends StatelessWidget {
  final Challenge challenge;
  final Function(Challenge) onTap;
  ChallengeTile(this.challenge, {this.onTap});

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
                if (onTap != null) onTap(challenge);
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
