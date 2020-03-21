import 'package:dio/dio.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge_api.dart';

class HttpChallengeApi implements ChallengeApi {
  String baseUrl;
  Dio dio;

  Map<String, dynamic> defaultQueryParams;

  HttpChallengeApi({this.baseUrl, this.dio}) : defaultQueryParams = {};

  @override
  Future<List<Challenge>> getAllChallenges() async {
    var response = await dio.get("$baseUrl/api/challenges");
    return Challenge.fromJsonList(response.data);
  }

  @override
  Future<List<Challenge>> getAllIncompletedChallenges() async {
    var response = await dio.get("$baseUrl/api/challenges/incomplete");
    return Challenge.fromJsonList(response.data);
  }
}
