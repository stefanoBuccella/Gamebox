import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../domain/models/game.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository;
  final SupabaseClient _supabase;
  
  UserViewModel(this._repository, this._supabase) {
    _init();
  }

  String? _username;
  List<Game> _diary = [];
  List<Game> _toPlay = [];
  List<Game> _top3Games = [];
  bool _isLoading = false;

  String? get username => _username;
  List<Game> get diary => _diary;
  List<Game> get toPlay => _toPlay;
  List<Game> get top3Games => _top3Games;
  bool get isLoading => _isLoading;

  Future<void> _init() async {
    await fetchAllData();
  }

  Future<void> fetchAllData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();
    
    try {
      final profile = await _repository.getProfile(user.id);
      _username = profile?['username'] ?? user.userMetadata?['username'];
      
      // Carica Top 3 Games dal profilo (tabella profiles - colonna top_games)
      final List<dynamic>? topGamesData = profile?['top_games'];
      if (topGamesData != null) {
        _top3Games = topGamesData.map((g) => Game.fromJson(g as Map<String, dynamic>)).toList();
      } else {
        _top3Games = [];
      }

      final diaryData = await _repository.getDiary(user.id);
      _diary = diaryData.map((d) => Game.fromJson(d['game_json'])).toList();

      final toPlayData = await _repository.getToPlay(user.id);
      _toPlay = toPlayData.map((t) => Game.fromJson(t['game_json'])).toList();
      
    } catch (e) {
      debugPrint("Errore fetch dati: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Aggiunge un gioco alla Top 3
  Future<void> addToTop3(Game game) async {
    final user = _supabase.auth.currentUser;
    if (user == null || _top3Games.length >= 3 || _top3Games.any((g) => g.id == game.id)) return;

    _top3Games.add(game);
    notifyListeners();
    await _repository.updateTopGames(user.id, _top3Games.map((g) => g.toJson()).toList());
  }

  // Rimuove un gioco dalla Top 3
  Future<void> removeFromTop3(String gameId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    _top3Games.removeWhere((g) => g.id == gameId);
    notifyListeners();
    await _repository.updateTopGames(user.id, _top3Games.map((g) => g.toJson()).toList());
  }

  bool isInToPlay(String gameId) => _toPlay.any((g) => g.id == gameId);

  Future<void> toggleToPlay(Game game) async {
    try {
      if (isInToPlay(game.id)) {
        await _repository.removeFromToPlay(game.id);
        _toPlay.removeWhere((g) => g.id == game.id);
      } else {
        await _repository.addToToPlay(game);
        _toPlay.add(game);
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Errore toggle To Play: $e");
    }
  }

  Future<void> addToDiary(Game game, double rating, String note) async {
    try {
      await _repository.saveReview(game, rating, note);
      // Ricarica il diario, ma NON tocca la Top 3
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final diaryData = await _repository.getDiary(user.id);
        _diary = diaryData.map((d) => Game.fromJson(d['game_json'])).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Errore salvataggio Diario: $e");
    }
  }
}
