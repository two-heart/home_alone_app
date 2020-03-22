import 'package:home_alone/model/challenge.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accepted_challenge.g.dart';

@JsonSerializable(nullable: false)
class AcceptedChallenge {
  bool finished;
  @JsonKey(nullable: true)
  DateTime finishedAt;
  DateTime acceptedAt;
  Challenge challenge;

  AcceptedChallenge({this.finished, this.finishedAt, this.acceptedAt, this.challenge});

  factory AcceptedChallenge.fromJson(Map<String, dynamic> json) =>
      _$AcceptedChallengeFromJson(json);

  static List<AcceptedChallenge> fromJsonList(List<dynamic> json) =>
      json.map((item) => _$AcceptedChallengeFromJson(item)).toList();

  Map<String, dynamic> toJson() => _$AcceptedChallengeToJson(this);
}