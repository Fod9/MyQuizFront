import 'package:flutter/material.dart';

class QuizData extends ChangeNotifier {
  int _score = 0;
  int _total = 0;

  int _userId = -1;
  int _quizId = -1;

  int get score => _score;
  int get total => _total;
  int get userId => _userId;
  int get quizId => _quizId;

  void addScore(int increment) => _score += increment;

  void setTotal(int value) => _total = value;

  void setUserId(int value) => _userId = value;

  void setQuizId(int value) => _quizId = value;

  Future<void> sendScore() async {
    final double note = _score * 20 / _total;

  }

  @override
  String toString() {
    return 'QuizData{score: $_score, total: $_total, userId: $_userId, quizId: $_quizId}';
  }
}