import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    required String id,
    required String title,
    String? imageUrl,
    String? publisher,
    @Default([]) List<String> platforms,
    @Default([]) List<String> genres,
    double? rating,
    int? releaseYear,
    String? summary,
  }) = _Game;

  factory Game.fromJson(Map<String, Object?> json) => _$GameFromJson(json);
}
