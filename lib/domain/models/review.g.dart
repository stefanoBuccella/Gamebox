// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  gameId: json['gameId'] as String,
  rating: (json['rating'] as num).toDouble(),
  note: json['note'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'gameId': instance.gameId,
  'rating': instance.rating,
  'note': instance.note,
  'createdAt': instance.createdAt.toIso8601String(),
};
