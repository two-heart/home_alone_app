import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true)
class User {
  User(
    this.name,
    this.profileImageUrl,
    this.id,
  );

  final String name;
  final String profileImageUrl;
  final String id;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
