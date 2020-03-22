import 'package:flutter/material.dart';
import 'package:home_alone/viewmodel/challenge_model.dart';

class ChallengesModel extends ChangeNotifier {
  List<ChallengeModel> _challenges = List<ChallengeModel>();
  List<ChallengeModel> get challenges => _challenges;
  set challenges(List<ChallengeModel> newChallenges) {
    _challenges = newChallenges;
    newChallenges?.forEach((f) => f.addListener(_notifyListeners));
    notifyListeners();
  }

  void _notifyListeners() => notifyListeners();
}
