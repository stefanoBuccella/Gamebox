import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

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

  Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    return await client.from('profiles').select().eq('id', userId).maybeSingle();
  }

  Future<List<Map<String, dynamic>>> fetchUserDiary(String userId) async {
    return await client.from('diary')
        .select('*, profiles(username)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }

  Future<List<Map<String, dynamic>>> fetchGameReviews(String gameId) async {
    try {
      final userId = client.auth.currentUser?.id;
      
      final reviewsResponse = await client.from('diary')
          .select('id, rating, review_text, created_at, likes_count, game_json, profiles(username)')
          .eq('game_id', gameId);

      List<dynamic> myLikes = [];
      if (userId != null) {
        myLikes = await client.from('interactions')
            .select('target_id')
            .eq('user_id', userId)
            .eq('target_type', 'review');
      }

      final likedIds = myLikes.map((l) => l['target_id'].toString()).toSet();

      return (reviewsResponse as List).map((item) {
        final row = Map<String, dynamic>.from(item as Map);
        final String id = row['id'].toString();
        row['is_liked_by_me'] = likedIds.contains(id);
        return row;
      }).cast<Map<String, dynamic>>().toList();
    } catch (e) {
      debugPrint('Error fetching reviews: $e');
      return [];
    }
  }

  Future<void> toggleLike(String reviewId, bool isLiked) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    if (isLiked) {
      await client.from('interactions').delete()
          .eq('user_id', userId)
          .eq('target_id', int.parse(reviewId))
          .eq('target_type', 'review');
    } else {
      await client.from('interactions').insert({
        'user_id': userId,
        'target_id': int.parse(reviewId),
        'target_type': 'review',
      });
    }
  }

  Future<void> saveToDiary({
    String? id,
    required String gameId,
    required Map<String, dynamic> gameJson,
    required double rating,
    required String reviewText,
  }) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    final data = {
      'user_id': userId,
      'game_id': gameId,
      'game_json': gameJson,
      'rating': rating,
      'review_text': reviewText,
    };

    if (id != null) {
      data['id'] = int.parse(id);
    }

    await client.from('diary').upsert(data, onConflict: 'user_id, game_id');
  }

  Future<void> removeFromDiary(String gameId) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('diary').delete().eq('user_id', userId).eq('game_id', gameId);
  }

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

  Future<List<Map<String, dynamic>>> fetchUserLists(String userId) async {
    try {
      debugPrint("Supabase: Fetching lists for $userId");
      final response = await client.from('user_lists')
          .select('*, profiles!left(username)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      
      final list = (response as List).cast<Map<String, dynamic>>();
      debugPrint("Supabase: Found ${list.length} user lists");
      return list;
    } catch (e) {
      debugPrint("Error fetching user lists: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchPublicLists() async {
    try {
      final userId = client.auth.currentUser?.id;
      final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7)).toIso8601String();

      debugPrint("Supabase: Fetching public lists since $oneWeekAgo");
      final response = await client.from('user_lists')
          .select('*, profiles!left(username)')
          .eq('is_public', true)
          .gte('created_at', oneWeekAgo);

      final lists = (response as List).cast<Map<String, dynamic>>();
      debugPrint("Supabase: Found ${lists.length} public lists raw");

      List<dynamic> myVotes = [];
      if (userId != null) {
        myVotes = await client.from('interactions')
            .select('target_id, interaction_value')
            .eq('user_id', userId)
            .eq('target_type', 'list');
      }

      final voteMap = {for (var v in myVotes) v['target_id'].toString(): v['interaction_value'] as int};

      return lists.map((item) {
        final row = Map<String, dynamic>.from(item);
        row['my_vote'] = voteMap[row['id'].toString()] ?? 0;
        return row;
      }).toList();
    } catch (e) {
      debugPrint("Error fetching public lists: $e");
      return [];
    }
  }

  Future<void> createList(String title, String? description, bool isPublic, List<Map<String, dynamic>> gamesJson) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('user_lists').insert({
      'user_id': userId,
      'title': title,
      'description': description,
      'is_public': isPublic,
      'games_json': gamesJson,
      'games_ids': gamesJson.map((g) => g['id'].toString()).toList(),
    });
  }

  Future<void> toggleListVote(String listId, int value) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    final existing = await client.from('interactions')
        .select()
        .eq('user_id', userId)
        .eq('target_id', int.parse(listId))
        .eq('target_type', 'list')
        .maybeSingle();

    if (existing != null) {
      if (existing['interaction_value'] == value) {
        await client.from('interactions').delete().eq('id', existing['id']);
      } else {
        await client.from('interactions').update({'interaction_value': value}).eq('id', existing['id']);
      }
    } else {
      await client.from('interactions').insert({
        'user_id': userId,
        'target_id': int.parse(listId),
        'target_type': 'list',
        'interaction_value': value,
      });
    }
  }

  Future<void> updateList(String listId, String title, String? description, bool isPublic, List<Map<String, dynamic>> gamesJson) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('user_lists').update({
      'title': title,
      'description': description,
      'is_public': isPublic,
      'games_json': gamesJson,
      'games_ids': gamesJson.map((g) => g['id'].toString()).toList(),
    }).eq('id', int.parse(listId)).eq('user_id', userId);
  }

  Future<void> deleteList(String listId) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('user_lists')
        .delete()
        .eq('id', int.parse(listId))
        .eq('user_id', userId);
  }
}
