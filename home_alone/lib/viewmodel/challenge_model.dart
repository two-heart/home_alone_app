import 'package:flutter/material.dart';

import 'package:home_alone/model/challenge.dart';

class ChallengeModel extends ChangeNotifier {
  ChallengeModel(Challenge challenge) {
    _challenge = challenge;
  }
  Challenge _challenge;
  Challenge get challenge => _challenge;
  set challenge(Challenge value) {
    _challenge = value;
    notifyListeners();
  }
}
