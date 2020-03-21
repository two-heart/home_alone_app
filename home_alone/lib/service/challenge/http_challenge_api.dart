import 'package:dio/dio.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';

typedef ResultMapper<T> = T Function(dynamic data);
enum ResponseErrorType { NOT_AUTHENTICATED, FORBIDDEN, SERVER_ERROR }

class HttpChallengeApi implements ChallengeApi {
  String baseUrl;
  Dio dio;

  Map<String, dynamic> defaultQueryParams;

  HttpChallengeApi({this.baseUrl, this.dio}) : defaultQueryParams = {};

  @override
  Future<List<Challenge>> getAllChallenges() async {
    var response = await dio.get("$baseUrl/api/challenges");
    return determineResponse(response, (data) => Challenge.fromJsonList(data));
  }

  @override
  Future<List<Challenge>> getAllIncompletedChallenges() async {
    var response = await dio.get("$baseUrl/api/challenges/incomplete");
    return determineResponse(
        response, (data) => Challenge.fromJsonList(response.data));
  }

  Future<T> determineResponse<T>(
      Response<dynamic> response, ResultMapper<T> mapper) {
    if (response == null) {
      Future.error(ResponseErrorType.SERVER_ERROR);
    }

    if (response.statusCode == 200) {
      return Future.value(mapper(response.data));
    } else if (response.statusCode == 401) {
      return Future.error(ResponseErrorType.NOT_AUTHENTICATED);
    } else if (response.statusCode == 403) {
      return Future.error(ResponseErrorType.FORBIDDEN);
    } else {
      return Future.error(ResponseErrorType.SERVER_ERROR);
    }
  }

  @override
  Future<List<Challenge>> findChallenges(String query) async {
    var response =
        await dio.get("$baseUrl/api/challenges/search", queryParameters: {
      "q": query,
    });
    return determineResponse(
        response, (data) => Challenge.fromJsonList(response.data));
  }
}
