import 'game_ref.dart';
/// ogni entry punta a un gioco GameRef e aggiunge dati dell'utente
class DiaryEntry {
  final GameRef game;
  final DateTime loggedAt;
  final String? platform;
  /// Voto stile Letterboxd: 0.5 ... 5.0
  final double? rating;
  /// mini-review
  final String? notes;
  /// Chiave univoca della entry nel Diary.
  int get igdbId => game.igdbId;



  const DiaryEntry({
    required this.game,
    required this.loggedAt,
    this.platform,
    this.rating,
    this.notes
  });

  DiaryEntry copyWith({
    GameRef? game,
    DateTime? loggedAt,
    String? platform,
    double? rating,
    String? notes
  }) {
    return DiaryEntry(
      game: game ?? this.game,
      loggedAt: loggedAt ?? this.loggedAt,
      platform: platform ?? this.platform,
      rating: rating ?? this.rating,
      notes: notes ?? this.notes
    );
  }



  Map<String, Object?> toJson() => {
        'game': game.toJson(),
        //ISO-8601 == standard e comodo per DB
        'loggedAt': loggedAt.toIso8601String(),
        'platform': platform,
        'rating': rating,
        'notes': notes
      };



  factory DiaryEntry.fromJson(Map<String, Object?> json) {
    return DiaryEntry(
      game: GameRef.fromJson((json['game'] as Map).cast<String, Object?>()),
      loggedAt: DateTime.parse(json['loggedAt'] as String),
      platform: json['platform'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );
  }

  @override
  String toString() =>
      'DiaryEntry(igdbId: ${game.igdbId}, loggedAt: $loggedAt)';
}
