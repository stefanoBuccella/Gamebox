import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  // AUTH
  Future<AuthResponse> signUp({required String email, required String password, required String username}) async {
    try {
      return await client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'username': username},
      );
    } catch (e) {
      debugPrint('ERRORE Signup: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signIn(String email, String password) async {
    try {
      return await client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
    } catch (e) {
      debugPrint('ERRORE Signin: $e');
      rethrow;
    }
  }

  Future<void> signOut() async => await client.auth.signOut();

  User? get currentUser => client.auth.currentUser;


  // DATABASE - PROFILO

  Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    return await client.from('profiles').select().eq('id', userId).maybeSingle();
  }


  // DATABASE - DIARIO

  Future<List<Map<String, dynamic>>> fetchUserDiary(String userId) async {
    return await client.from('diary')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }

  Future<void> saveToDiary({
    required String gameId,
    required Map<String, dynamic> gameJson,
    required double rating,
    required String reviewText,
  }) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('diary').upsert({
      'user_id': userId,
      'game_id': gameId,
      'game_json': gameJson,
      'rating': rating,
      'review_text': reviewText,
    });
  }


  // DATABASE - TO PLAY
  Future<List<Map<String, dynamic>>> fetchUserToPlay(String userId) async {
    return await client.from('to_play')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }

  Future<void> saveToToPlay(String gameId, Map<String, dynamic> gameJson) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('to_play').upsert({
      'user_id': userId,
      'game_id': gameId,
      'game_json': gameJson,
    });
  }

  Future<void> removeFromToPlay(String gameId) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('to_play').delete().eq('user_id', userId).eq('game_id', gameId);
  }
}
