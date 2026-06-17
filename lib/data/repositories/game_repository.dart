import '../../domain/models/game.dart';
import '../services/igdb_service.dart';

class GameRepository {
  final IgdbService _igdbService = IgdbService();

  Future<List<Game>> searchGames(String query) async {
    final results = await _igdbService.searchGames(query);
    
    return results.map((json) {
      try {
        return Game(
          id: json['id'].toString(),
          title: json['name'] ?? 'Titolo non disponibile',
          imageUrl: json['cover'] != null 
              ? 'https:${json['cover']['url']}'.replaceAll('t_thumb', 't_cover_big') 
              : null,
          publisher: (json['involved_companies'] as List?)?.firstWhere((c) => c['publisher'] == true, orElse: () => null)?['company']?['name'],
          platforms: (json['platforms'] as List?)?.map((p) => p['name'].toString()).toList() ?? [],
          genres: (json['genres'] as List?)?.map((g) => g['name'].toString()).toList() ?? [],
          rating: json['total_rating'] != null ? (json['total_rating'] as num).toDouble() / 20.0 : null,
          summary: json['summary'],
        );
      } catch (e) {
        return const Game(id: 'err', title: 'Errore caricamento');
      }
    }).where((game) => game.id != 'err').toList();
  }

  Future<List<Game>> getHomeGames() async {
    // Simuliamo un ritardo di caricamento
    await Future.delayed(const Duration(milliseconds: 500));

    // Restituiamo una lista vuota per lo sprint attuale
    return [];
  }
}