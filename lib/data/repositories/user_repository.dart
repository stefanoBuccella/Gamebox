import 'package:flutter/foundation.dart';
import '../services/supabase_service.dart';
import '../../domain/models/game.dart';
import '../../domain/models/diary_entry.dart';
import '../../domain/models/user_list.dart';

class UserRepository {
  final SupabaseService _service;
  UserRepository(this._service);

  // AUTH & PROFILO
  Future<bool> signIn(String email, String password) async {
    await _service.signIn(email, password);
    return true;
  }

  Future<bool> signUp(String email, String password, String username) async {
    final response = await _service.signUp(email: email, password: password, username: username);
    if (response.user != null) {
      try {
        await _service.client.from('profiles').upsert({'id': response.user!.id, 'username': username});
      } catch (e) {
        debugPrint('Errore creazione profilo: $e');
      }
    }
    return true;
  }

  Future<void> signOut() async => await _service.signOut();

  Future<Map<String, dynamic>?> getProfile(String userId) => _service.fetchProfile(userId);

  // Aggiorna i top_games nel profilo
  Future<void> updateTopGames(String userId, List<Map<String, dynamic>> topGamesJson) async {
    await _service.client.from('profiles').update({
      'top_games': topGamesJson,
    }).eq('id', userId);
  }

  // DIARIO
  Future<List<Map<String, dynamic>>> getDiary(String userId) => _service.fetchUserDiary(userId);

  Future<void> saveReview(Game game, double rating, String note, {String? id}) async {
    await _service.saveToDiary(
      id: id,
      gameId: game.id,
      gameJson: game.toJson(),
      rating: rating,
      reviewText: note,
    );
  }

  Future<void> deleteReview(String gameId) async => await _service.removeFromDiary(gameId);

  Future<List<DiaryEntry>> getGameReviews(String gameId) async {
    final data = await _service.fetchGameReviews(gameId);
    return data.map((d) => DiaryEntry.fromJson(d)).toList();
  }

  Future<void> toggleLike(String reviewId, bool isLiked) async {
    await _service.toggleLike(reviewId, isLiked);
  }

  // TO PLAY
  Future<List<Map<String, dynamic>>> getToPlay(String userId) => _service.fetchUserToPlay(userId);

  Future<void> addToToPlay(Game game) async => await _service.saveToToPlay(game.id, game.toJson());

  Future<void> removeFromToPlay(String gameId) async => await _service.removeFromToPlay(gameId);

  // LISTE
  Future<List<UserList>> getUserLists(String userId) async {
    final data = await _service.fetchUserLists(userId);
    return data.map((l) => UserList.fromJson(l)).where((l) => l.id != 'error').toList();
  }

  Future<List<UserList>> getPublicLists() async {
    final data = await _service.fetchPublicLists();
    return data.map((l) => UserList.fromJson(l)).where((l) => l.id != 'error').toList();
  }

  Future<void> createList(String title, String? description, bool isPublic, List<Game> games) async {
    await _service.createList(title, description, isPublic, games.map((g) => g.toJson()).toList());
  }

  Future<void> voteList(String listId, int value) async {
    await _service.toggleListVote(listId, value);
  }

  Future<void> updateList(String listId, String title, String? description, bool isPublic, List<Game> games) async {
    await _service.updateList(listId, title, description, isPublic, games.map((g) => g.toJson()).toList());
  }

  Future<void> deleteList(String listId) async {
    await _service.deleteList(listId);
  }
}
