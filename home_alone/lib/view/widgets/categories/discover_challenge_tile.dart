import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/widgets/themed_button.dart';

class DiscoverChallengeTile extends StatelessWidget {
  final Challenge challenge;
  DiscoverChallengeTile(this.challenge);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.work),
                Text(challenge.category.name)
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                        "https://blog.photofeeler.com/wp-content/uploads/2017/09/tinder-photo-size-tinder-picture-size-tinder-aspect-ratio-image-dimensions-crop.jpg",
                      ),
                    ))),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Text(
                      challenge.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            Text(
              challenge.teaser,
              maxLines: 3,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Zur Challenge"),
                      onPressed: () {},
                    ),
                    ThemedButton(
                        text: "Teilnehmen", width: 120, onPressed: () {})
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
