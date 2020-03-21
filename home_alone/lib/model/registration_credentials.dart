import 'package:json_annotation/json_annotation.dart';

part 'registration_credentials.g.dart';

@JsonSerializable(nullable: true)
class RegistrationCredentials {
  RegistrationCredentials({
    this.username,
    this.email,
    this.password,
  });
  final String username;
  final String email;
  final String password;

  factory RegistrationCredentials.fromJson(Map<String, dynamic> json) =>
      _$RegistrationCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationCredentialsToJson(this);
}
