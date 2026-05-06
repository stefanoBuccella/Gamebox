class GameRef {
  /// ID del gioco su IGDB
  final int igdbId;
  final String title;
  final String? coverUrl;
  final String? summary;
  final DateTime? releaseDate;
  /// in IGDB può arrivare da involved_companies.
  final String? publisher;
  final List<String> genres;
  /// Piattaforme su cui il gioco è disponibile
  final List<String> platforms;



  const GameRef({
    required this.igdbId,
    required this.title,
    this.coverUrl,
    this.summary,
    this.releaseDate,
    this.publisher,
    this.genres = const [],
    this.platforms = const []
  });



  GameRef copyWith({
    int? igdbId,
    String? title,
    String? coverUrl,
    String? summary,
    DateTime? releaseDate,
    String? publisher,
    List<String>? genres,
    List<String>? platforms
  }) {
    return GameRef(
      igdbId: igdbId ?? this.igdbId,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      summary: summary ?? this.summary,
      releaseDate: releaseDate ?? this.releaseDate,
      publisher: publisher ?? this.publisher,
      genres: genres ?? this.genres,
      platforms: platforms ?? this.platforms
    );
  }



  Map<String, Object?> toJson() => {
        'igdbId': igdbId,
        'title': title,
        'coverUrl': coverUrl,
        'summary': summary,
        'releaseDate': releaseDate?.toIso8601String(),
        'publisher': publisher,
        'genres': genres,
        'platforms': platforms
      };

  
  factory GameRef.fromJson(Map<String, Object?> json) {
    return GameRef(
      igdbId: (json['igdbId'] as num).toInt(),
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String?,
      summary: json['summary'] as String?,
      releaseDate: (json['releaseDate'] as String?) == null ? null : DateTime.parse(json['releaseDate'] as String),
      publisher: json['publisher'] as String?,
      genres: (json['genres'] as List?)?.cast<String>() ?? const [],
      platforms: (json['platforms'] as List?)?.cast<String>() ?? const []
    );
  }

  @override
  String toString() => 'GameRef(igdbId: $igdbId, title: $title)';
}
