// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginCredentials _$LoginCredentialsFromJson(Map<String, dynamic> json) {
  return LoginCredentials(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$LoginCredentialsToJson(LoginCredentials instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
