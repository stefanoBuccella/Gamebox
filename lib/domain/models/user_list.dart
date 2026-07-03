import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'game.dart';

part 'user_list.freezed.dart';

@freezed
abstract class UserList with _$UserList {
  const factory UserList({
    required String id,
    required String userId,
    @Default('User') String username,
    required String title,
    String? description,
    @Default(true) bool isPublic,
    @Default(0) int upvotesCount,
    @Default(0) int downvotesCount,
    @Default([]) List<Game> games,
    required DateTime createdAt,
    @Default(0) int myVote,
  }) = _UserList;

  factory UserList.fromJson(Map<String, dynamic> json) {
    try {
      final profiles = json['profiles'] as Map<String, dynamic>?;
      final username = profiles?['username'] as String? ?? 'User';

      final gamesRaw = json['games_json'] as List? ?? [];
      final List<Game> games = [];
      for (var g in gamesRaw) {
        try {
          if (g != null) {
            games.add(Game.fromJson(Map<String, dynamic>.from(g as Map)));
          }
        } catch (e) {
          debugPrint("Skip individual game mapping error: $e");
        }
      }

      DateTime parsedDate;
      try {
        parsedDate = json['created_at'] != null ? DateTime.parse(json['created_at'].toString()) : DateTime.now();
      } catch (_) {
        parsedDate = DateTime.now();
      }

      return UserList(
        id: json['id']?.toString() ?? '0',
        userId: json['user_id']?.toString() ?? '',
        username: username,
        title: json['title']?.toString() ?? 'Untitled List',
        description: json['description']?.toString(),
        isPublic: json['is_public'] == true,
        upvotesCount: int.tryParse(json['upvotes_count']?.toString() ?? '0') ?? 0,
        downvotesCount: int.tryParse(json['downvotes_count']?.toString() ?? '0') ?? 0,
        games: games,
        createdAt: parsedDate,
        myVote: int.tryParse(json['my_vote']?.toString() ?? '0') ?? 0,
      );
    } catch (e, stack) {
      debugPrint("CRITICAL Mapping error for list: $e\n$stack");
      return UserList(
        id: 'error',
        userId: '',
        title: 'Error loading list',
        createdAt: DateTime.now(),
      );
    }
  }
}
