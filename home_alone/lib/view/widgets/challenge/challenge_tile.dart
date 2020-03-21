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
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(2, 2))
            ]),
        child: Padding(
          child: ListTile(
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
          padding: EdgeInsets.all(8),
        ),
      ),
      padding: EdgeInsets.all(8),
    );
  }
}
