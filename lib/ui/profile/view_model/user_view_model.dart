import 'package:flutter/material.dart';
import '../../../domain/models/game.dart';
import '../../../domain/models/review.dart';

class UserViewModel extends ChangeNotifier {
  final List<Game> _diary = [];
  final List<Game> _toPlay = [];
  final Map<String, Review> _reviews = {};
  
  List<Game> get diary => _diary;
  List<Game> get toPlay => _toPlay;

  void addToDiary(Game game, Review review) {
    if (!_diary.any((g) => g.id == game.id)) {
      _diary.add(game);
      _reviews[game.id] = review;
      notifyListeners();
    }
  }

  void addToToPlay(Game game) {
    if (!_toPlay.any((g) => g.id == game.id)) {
      _toPlay.add(game);
      notifyListeners();
    }
  }

  Review? getReview(String gameId) => _reviews[gameId];
}
