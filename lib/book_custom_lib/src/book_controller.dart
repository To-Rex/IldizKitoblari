import 'package:flutter/material.dart';

class BookController extends ChangeNotifier {
  int nextType = 0;
  int currentIndex = 0; // 当前页
  int goToIndex = 0; // 跳转页

  /// Oldingi sahifa
  void last() {
    nextType = -1;
    notifyListeners();
  }

  /// Keyingi sahifa
  void next() {
    nextType = 1;
    notifyListeners();
  }

  /// O'tish sahifasi
  void goTo(int index) {
    nextType = 0;
    goToIndex = index;
    notifyListeners();
  }
}
