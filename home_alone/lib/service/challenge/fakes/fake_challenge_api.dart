import 'dart:convert';

import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';

import 'challenge_data.dart';

class FakeChallengeApi implements ChallengeApi {
  @override
  Future<List<Challenge>> getAllChallenges() async {
    return Challenge.fromJsonList(jsonDecode(all));
  }

  @override
  Future<List<Challenge>> getAllIncompletedChallenges() async {
    return Challenge.fromJsonList(jsonDecode(incomplete));
  }
}
