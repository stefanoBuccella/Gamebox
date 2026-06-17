import 'package:flutter/material.dart';
import '../../../../data/repositories/user_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final UserRepository _repo;
  AuthViewModel(this._repo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      return await _repo.signIn(email, password);
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password, String username) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      return await _repo.signUp(email, password, username);
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async => await _repo.signOut();
}
