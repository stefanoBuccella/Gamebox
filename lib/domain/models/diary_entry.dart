import 'package:freezed_annotation/freezed_annotation.dart';
import 'game.dart';

part 'diary_entry.freezed.dart';
part 'diary_entry.g.dart';

@freezed
abstract class DiaryEntry with _$DiaryEntry {
  const factory DiaryEntry({
    required String id,
    required Game game,
    required double rating,
    required String reviewText,
    required DateTime createdAt,
    @Default(0) int likesCount,
    @Default(false) bool isLikedByMe,
    String? username,
  }) = _DiaryEntry;

  factory DiaryEntry.fromJson(Map<String, dynamic> json) => _$DiaryEntryFromJson({
    'id': json['id'].toString(),
    'game': json['game_json'],
    'rating': (json['rating'] as num).toDouble(),
    'reviewText': json['review_text'] ?? '',
    'createdAt': json['created_at'],
    'likesCount': json['likes_count'] ?? 0,
    'isLikedByMe': json['is_liked_by_me'] ?? false,
    'username': json['profiles']?['username'],
  });
}
