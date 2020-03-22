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
  Future<List<Challenge>> getSubscribedChallenges() async {
    return Challenge.fromJsonList(jsonDecode(all));
  }

  @override
  Future<List<Challenge>> getAcceptedChallenges() async {
    return Challenge.fromJsonList(jsonDecode(accepted));
  }

  @override
  Future<List<Challenge>> findChallenges(String query) async {
    final challenges = await getAllChallenges();
    var result = challenges
        .where((challenge) => challenge.name.toLowerCase().startsWith(query))
        .toList();
    return result;
  }

  @override
  Future<void> acceptChallenge(String id) async {}
}
