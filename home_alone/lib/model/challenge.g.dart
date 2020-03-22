// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return Challenge(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    teaser: json['teaser'] as String,
    imageUrl: json['imageUrl'] as String,
    category: Category.fromJson(json['category'] as Map<String, dynamic>),
    accepted: json['accepted'] as bool,
  );
}

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'teaser': instance.teaser,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'accepted': instance.accepted,
    };
