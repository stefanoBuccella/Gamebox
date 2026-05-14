import 'package:flutter/material.dart';
import '../../../domain/models/game.dart';
import '../../../data/repositories/game_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final GameRepository _repository;
  HomeViewModel(this._repository);

  List<Game> _games = [];
  bool _isLoading = false;

  List<Game> get games => _games;
  bool get isLoading => _isLoading;

  Future<void> fetchGames() async {
    _isLoading = true;
    notifyListeners(); //Mostra lo spinner nella UI

    try {
      _games = await _repository.getHomeGames();
    } catch (e) {
      debugPrint("Errore: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); //Mostra i dati
    }
  }
}