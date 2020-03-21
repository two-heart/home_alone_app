// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationCredentials _$RegistrationCredentialsFromJson(
    Map<String, dynamic> json) {
  return RegistrationCredentials(
    username: json['username'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$RegistrationCredentialsToJson(
        RegistrationCredentials instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
