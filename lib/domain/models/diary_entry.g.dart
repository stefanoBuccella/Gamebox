// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) => _DiaryEntry(
  id: json['id'] as String,
  game: Game.fromJson(json['game'] as Map<String, dynamic>),
  rating: (json['rating'] as num).toDouble(),
  reviewText: json['reviewText'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  isLikedByMe: json['isLikedByMe'] as bool? ?? false,
  username: json['username'] as String?,
);

Map<String, dynamic> _$DiaryEntryToJson(_DiaryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'game': instance.game,
      'rating': instance.rating,
      'reviewText': instance.reviewText,
      'createdAt': instance.createdAt.toIso8601String(),
      'likesCount': instance.likesCount,
      'isLikedByMe': instance.isLikedByMe,
      'username': instance.username,
    };
