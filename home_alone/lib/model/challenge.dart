import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable(nullable: false)
class Challenge {
  String id;
  String name;
  String description;
  bool accepted = false;

  Challenge({this.id, this.name, this.description});

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);

  static List<Challenge> fromJsonList(List<dynamic> json) =>
      json.map((item) => _$ChallengeFromJson(item)).toList();

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}
