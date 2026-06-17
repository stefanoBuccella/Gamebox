import 'package:flutter/material.dart';
import '../../../data/repositories/game_repository.dart';
import '../../../domain/models/game.dart';

class SearchViewModel extends ChangeNotifier {
  final GameRepository _gameRepository;
  SearchViewModel(this._gameRepository);

  List<Game> _searchResults = [];
  bool _isLoading = false;

  List<Game> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _gameRepository.searchGames(query);
    } catch (e) {
      debugPrint("Errore generale nella ricerca: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
