import 'package:home_alone/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable(nullable: false)
class Challenge {
  String id;
  String name;
  String description;
  String teaser;
  String imageUrl;
  Category category;
  bool get accepted => finished != null;

  @JsonKey(nullable: true)
  bool finished;
  @JsonKey(nullable: true)
  DateTime finishedAt;
  @JsonKey(nullable: true)
  DateTime acceptedAt;



  Challenge(
      {this.id,
      this.name,
      this.description,
      this.teaser,
      this.imageUrl,
      this.category,
      this.finished,
      this.acceptedAt,
      this.finishedAt});

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);

  static List<Challenge> fromJsonList(List<dynamic> json) =>
      json.map((item) => _$ChallengeFromJson(item)).toList();

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}
