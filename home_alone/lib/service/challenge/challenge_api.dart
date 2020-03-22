import 'package:home_alone/model/accepted_challenge.dart';
import 'package:home_alone/model/challenge.dart';

abstract class ChallengeApi {
  Future<List<Challenge>> getAllChallenges();
  Future<List<Challenge>> getSubscribedChallenges();
  Future<List<AcceptedChallenge>> getAcceptedChallenges();
  Future<List<Challenge>> findChallenges(String query);
}
