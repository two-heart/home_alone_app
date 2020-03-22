// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepted_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptedChallenge _$AcceptedChallengeFromJson(Map<String, dynamic> json) {
  return AcceptedChallenge(
    finished: json['finished'] as bool,
    finishedAt: json['finishedAt'] == null
        ? null
        : DateTime.parse(json['finishedAt'] as String),
    acceptedAt: DateTime.parse(json['acceptedAt'] as String),
    challenge: Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AcceptedChallengeToJson(AcceptedChallenge instance) =>
    <String, dynamic>{
      'finished': instance.finished,
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'acceptedAt': instance.acceptedAt.toIso8601String(),
      'challenge': instance.challenge,
    };
