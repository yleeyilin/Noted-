import 'package:flutter/foundation.dart';

class ReputationScore with ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void updateScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }
}
