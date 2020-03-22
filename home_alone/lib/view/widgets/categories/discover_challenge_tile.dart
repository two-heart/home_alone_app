import 'package:flutter/material.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/view/pages/challenge_detail_page.dart';
import 'package:home_alone/view/widgets/themed_button.dart';

class DiscoverChallengeTile extends StatelessWidget {
  final Challenge challenge;

  DiscoverChallengeTile(this.challenge);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDetailPage(context),
      child: _buildContent(),
    );
  }

  Container _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: 350,
      child: Container(
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildCategoryHeader(),
            _buildImageSection(),
            _buildTeaserText(),
            _buildButtonRow()
          ],
        ),
      ),
    );
  }

  Stack _buildImageSection() {
    return Stack(
      children: <Widget>[
        _buildImage(),
        _buildText(),
      ],
    );
  }

  Row _buildCategoryHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[Icon(Icons.work), Text(challenge.category.name)],
    );
  }

  Text _buildTeaserText() => Text(challenge.teaser, maxLines: 1);

  Expanded _buildButtonRow() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ThemedButton(
                text: "Teilnehmen", width: 120, onPressed: _acceptChallenge)
          ],
        ),
      ),
    );
  }

  Positioned _buildText() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Text(
          challenge.name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ));
  }

  Container _buildImage() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(
            "https://blog.photofeeler.com/wp-content/uploads/2017/09/tinder-photo-size-tinder-picture-size-tinder-aspect-ratio-image-dimensions-crop.jpg",
          ),
        ),
      ),
    );
  }

  void _openDetailPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ChallengeDetail(challenge: challenge)),
    );
  }

  void _acceptChallenge() {}
}
