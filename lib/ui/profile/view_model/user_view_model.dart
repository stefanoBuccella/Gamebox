import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../domain/models/game.dart';
import '../../../domain/models/diary_entry.dart';
import '../../../domain/models/user_list.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository;
  final SupabaseClient _supabase;
  
  UserViewModel(this._repository, this._supabase) {
    _init();
    _supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn || data.event == AuthChangeEvent.initialSession) {
        fetchAllData();
      } else if (data.event == AuthChangeEvent.signedOut) {
        _clearData();
      }
    });
  }

  String? _username;
  List<DiaryEntry> _diary = [];
  List<Game> _toPlay = [];
  List<UserList> _myLists = [];
  List<UserList> _publicLists = [];
  List<Game> _top3Games = [];
  bool _isLoading = false;

  String? get username => _username;
  List<DiaryEntry> get diary => _diary;
  List<Game> get toPlay => _toPlay;
  List<UserList> get myLists => _myLists;
  List<UserList> get publicLists {
    final lists = List<UserList>.from(_publicLists);
    lists.sort((a, b) {
      final scoreA = a.upvotesCount - a.downvotesCount;
      final scoreB = b.upvotesCount - b.downvotesCount;
      return scoreB.compareTo(scoreA);
    });
    return lists;
  }
  List<Game> get top3Games => _top3Games;
  bool get isLoading => _isLoading;

  void _clearData() {
    _username = null;
    _diary = [];
    _toPlay = [];
    _myLists = [];
    _publicLists = [];
    _top3Games = [];
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _init() async {
    await fetchAllData();
  }

  Future<void> fetchAllData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      _clearData();
      return;
    }

    _isLoading = true;
    notifyListeners();
    
    try {
      final profile = await _repository.getProfile(user.id);
      _username = profile?['username'] ?? user.userMetadata?['username'];
      
      final List<dynamic>? topGamesData = profile?['top_games'];
      if (topGamesData != null) {
        _top3Games = topGamesData.map((g) => Game.fromJson(g as Map<String, dynamic>)).toList();
      } else {
        _top3Games = [];
      }

      final diaryData = await _repository.getDiary(user.id);
      _diary = diaryData.map((d) => DiaryEntry.fromJson(d)).toList();

      final toPlayData = await _repository.getToPlay(user.id);
      _toPlay = toPlayData.map((t) => Game.fromJson(t['game_json'])).toList();

      try {
        debugPrint("Fetching lists for user: ${user.id}");
        _myLists = await _repository.getUserLists(user.id);
        debugPrint("My lists count: ${_myLists.length}");
        
        _publicLists = await _repository.getPublicLists();
        debugPrint("Public lists count: ${_publicLists.length}");
      } catch (listError) {
        debugPrint("Error loading lists specific: $listError");
        _myLists = [];
        _publicLists = [];
      }
      
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
  bool isInDiary(String gameId) => _diary.any((d) => d.game.id == gameId);

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

  Future<void> addToDiary(Game game, double rating, String note, {String? id}) async {
    try {
      await _repository.saveReview(game, rating, note, id: id);
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final diaryData = await _repository.getDiary(user.id);
        _diary = diaryData.map((d) => DiaryEntry.fromJson(d)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Errore salvataggio Diario: $e");
    }
  }

  Future<void> deleteFromDiary(String gameId) async {
    try {
      await _repository.deleteReview(gameId);
      _diary.removeWhere((d) => d.game.id == gameId);
      notifyListeners();
    } catch (e) {
      debugPrint("Errore eliminazione Diario: $e");
    }
  }

  Future<List<DiaryEntry>> getGameReviews(String gameId) async {
    return await _repository.getGameReviews(gameId);
  }

  Future<void> toggleLike(DiaryEntry entry) async {
    try {
      await _repository.toggleLike(entry.id, entry.isLikedByMe);
    } catch (e) {
      debugPrint("Error toggling like: $e");
    }
  }

  // LISTE
  Future<void> createList(String title, String? description, bool isPublic, List<Game> games) async {
    try {
      await _repository.createList(title, description, isPublic, games);
      await fetchAllData();
    } catch (e) {
      debugPrint("Error creating list: $e");
    }
  }

  Future<void> voteList(UserList list, int value) async {
    try {
      await _repository.voteList(list.id, value);
      await fetchAllData();
    } catch (e) {
      debugPrint("Error voting list: $e");
    }
  }

  Future<void> updateList(String listId, String title, String? description, bool isPublic, List<Game> games) async {
    try {
      await _repository.updateList(listId, title, description, isPublic, games);
      await fetchAllData();
    } catch (e) {
      debugPrint("Error updating list: $e");
    }
  }

  Future<void> deleteList(String listId) async {
    try {
      await _repository.deleteList(listId);
      await fetchAllData();
    } catch (e) {
      debugPrint("Error deleting list: $e");
    }
  }
}
