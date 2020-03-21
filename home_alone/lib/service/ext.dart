import 'package:dio/dio.dart';
import 'package:home_alone/service/challenge/http_challenge_api.dart';

extension ResponseExt on Response {
  Future<T> evaluate<T>(ResultMapper<T> mapper) {
    if (this == null) {
      Future.error(ResponseErrorType.SERVER_ERROR);
    }

    if (this.statusCode == 200) {
      return Future.value(mapper(this.data));
    } else if (this.statusCode == 401) {
      return Future.error(ResponseErrorType.NOT_AUTHENTICATED);
    } else if (this.statusCode == 403) {
      return Future.error(ResponseErrorType.FORBIDDEN);
    } else {
      return Future.error(ResponseErrorType.SERVER_ERROR);
    }
  }
}
