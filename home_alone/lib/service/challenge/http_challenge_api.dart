import 'package:dio/dio.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/service/ext.dart';
import 'package:home_alone/viewmodel/challenge_model.dart';
import 'package:home_alone/viewmodel/challenges_model.dart';

typedef ResultMapper<T> = T Function(dynamic data);
enum ResponseType { NOT_AUTHENTICATED, FORBIDDEN, SERVER_ERROR }

class HttpChallengeApi implements ChallengeApi {
  String baseUrl;
  Dio dio;

  Map<String, dynamic> defaultQueryParams;

  HttpChallengeApi({
    this.baseUrl,
    this.dio,
    // this.challengesModel,
  }) : defaultQueryParams = {};

  ChallengesModel get challengesModel => locator.get<ChallengesModel>();

  @override
  Future<List<Challenge>> getAllChallenges() async {
    var response = await dio.get("$baseUrl/challenge");
    print(response);
    final challenges = Challenge.fromJsonList(response.data);
    challengesModel.challenges =
        challenges.map((f) => ChallengeModel(f)).toList();
    return challenges;
  }

  @override
  Future<List<Challenge>> getSubscribedChallenges() async {
    var response = await dio.get("$baseUrl/user/challenge");
    final challenges = Challenge.fromJsonList(response.data)
      ..where((f) => f.accepted == null);

    challengesModel.subScribedChallenges =
        challenges.map((f) => ChallengeModel(f)).toList();

    return challenges;
  }

  @override
  Future<List<Challenge>> getAcceptedChallenges() async {
    var response = await dio.get("$baseUrl/user/challenge/accepted");
    final challenges = Challenge.fromJsonList(response.data);
    _updateViewModel(challenges);

    return challenges;
  }

  void _updateViewModel(List<Challenge> challenges) {
    final selectedChallenges = challengesModel.challenges
        .where((c) => challenges.any((test) => test.id == c.challenge.id));

    selectedChallenges
        .forEach((f) => f.challenge = f.challenge..finished = false);
  }

  @override
  Future<List<Challenge>> findChallenges(String query) async {
    var challenges = (await getSubscribedChallenges());
    final result = challenges
            .where((x) => x.name.toLowerCase().contains(query.toLowerCase()))
            .toList() ??
        [];
    print(result);
    return result;
  }

  @override
  Future<bool> acceptChallenge(String id) async {
    var response = await dio.post("$baseUrl/challenge/$id/accept");
    print(response.statusCode);
    print(response.data);
    if (response.statusCode < 299) {}
  }

  @override
  Future<bool> finishChallenge(String challengeId) async {
    try {
      await dio.put("$baseUrl/challenge/$challengeId/finish");
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
