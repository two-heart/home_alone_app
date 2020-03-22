import 'package:home_alone/model/challenge.dart';

abstract class ChallengeApi {
  Future<List<Challenge>> getAllChallenges();
  Future<List<Challenge>> getAllSubscribedChallenges();
  Future<List<Challenge>> findChallenges(String query);
}
