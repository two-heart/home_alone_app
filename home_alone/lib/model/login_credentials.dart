import 'package:json_annotation/json_annotation.dart';

part 'login_credentials.g.dart';

@JsonSerializable(nullable: true)
class LoginCredentials {
  LoginCredentials(
    this.username,
    this.password,
  );
  final String username;
  final String password;

  factory LoginCredentials.fromJson(Map<String, dynamic> json) =>
      _$LoginCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginCredentialsToJson(this);
}
