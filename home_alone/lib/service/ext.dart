import 'package:dio/dio.dart';
import 'package:home_alone/service/challenge/http_challenge_api.dart';

extension ResponseExt on Response {
  Future<T> evaluate<T>(ResultMapper<T> mapper) {}
}
