import 'package:dio/dio.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/service/ext.dart';

typedef ResultMapper<T> = T Function(dynamic data);
enum ResponseType { NOT_AUTHENTICATED, FORBIDDEN, SERVER_ERROR }

class HttpChallengeApi implements ChallengeApi {
  String baseUrl;
  Dio dio;

  Map<String, dynamic> defaultQueryParams;

  HttpChallengeApi({this.baseUrl, this.dio}) : defaultQueryParams = {};

  @override
  Future<List<Challenge>> getAllChallenges() async {
    var response = await dio.get("$baseUrl/challenge");
    return Challenge.fromJsonList(response.data);
  }

  @override
  Future<List<Challenge>> getAllSubscribedChallenges() async {
    var response = await dio.get("$baseUrl/challenge");
    return response.evaluate((data) => Challenge.fromJsonList(response.data)) ??
        [];
  }

  @override
  Future<List<Challenge>> findChallenges(String query) async {
    var response = await dio.get("$baseUrl/challenge", queryParameters: {
      "q": query,
    });
    return response.evaluate((data) => Challenge.fromJsonList(response.data)) ??
        [];
  }
}
