import 'package:home_alone/model/challenge.dart';

abstract class ChallengeApi {
  Future<List<Challenge>> getAllChallenges();
  Future<List<Challenge>> getSubscribedChallenges();
  Future<List<Challenge>> getAcceptedChallenges();
  Future<List<Challenge>> findChallenges(String query);
  Future<void> acceptChallenge(String id);
}
