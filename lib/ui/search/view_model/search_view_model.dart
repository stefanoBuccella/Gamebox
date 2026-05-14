import 'package:flutter/material.dart';
import '../../../data/services/igdb_service.dart';
import '../../../domain/models/game.dart';

class SearchViewModel extends ChangeNotifier {
  final IgdbService _igdbService = IgdbService();
  List<Game> _searchResults = [];
  bool _isLoading = false;

  List<Game> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint("Inizio mappatura risultati per: $query");
      final results = await _igdbService.searchGames(query);
      
      _searchResults = results.map((json) {
        try {
          return Game(
            id: json['id'].toString(),
            title: json['name'] ?? 'Titolo non disponibile',
            imageUrl: json['cover'] != null 
                ? 'https:${json['cover']['url']}'.replaceAll('t_thumb', 't_cover_big') 
                : null,
            publisher: (json['involved_companies'] as List?)?.firstWhere((c) => c['publisher'] == true, orElse: () => null)?['company']?['name'],
            platforms: (json['platforms'] as List?)?.map((p) => p['name'].toString()).toList() ?? [],
            rating: json['total_rating'] != null ? (json['total_rating'] as num).toDouble() / 20.0 : null,
            summary: json['summary'],
          );
        } catch (e) {
          debugPrint("Errore mappatura singolo gioco: $e");
          return Game(id: 'err', title: 'Errore caricamento');
        }
      }).where((game) => game.id != 'err').toList();
      
      debugPrint("Mappatura completata: ${_searchResults.length} giochi trovati");
    } catch (e) {
      debugPrint("Errore generale nella ricerca: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
