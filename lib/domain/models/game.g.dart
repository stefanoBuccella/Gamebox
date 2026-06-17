// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Game _$GameFromJson(Map<String, dynamic> json) => _Game(
  id: json['id'] as String,
  title: json['title'] as String,
  imageUrl: json['imageUrl'] as String?,
  publisher: json['publisher'] as String?,
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  genres:
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  rating: (json['rating'] as num?)?.toDouble(),
  releaseYear: (json['releaseYear'] as num?)?.toInt(),
  summary: json['summary'] as String?,
);

Map<String, dynamic> _$GameToJson(_Game instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'imageUrl': instance.imageUrl,
  'publisher': instance.publisher,
  'platforms': instance.platforms,
  'genres': instance.genres,
  'rating': instance.rating,
  'releaseYear': instance.releaseYear,
  'summary': instance.summary,
};
