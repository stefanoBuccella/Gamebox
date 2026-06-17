import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  int _selectedIndex = 2; // Default to Profile

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
