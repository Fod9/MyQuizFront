import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/quiz/save_note.dart';
import 'package:my_quiz_ap/helpers/utils.dart';

class QuizData extends ChangeNotifier {
  int _score = 0;
  int _total = 0;

  int _userId = -1;
  int _quizId = -1;

  final DateTime _startTime = DateTime.now();
  int _timeElapsed = 0;

  int get score => _score;
  int get total => _total;
  DateTime get startTime => _startTime;

  void addScore(int increment) => _score += increment;

  void setTotal(int value) => _total = value;

  void setUserId(int value) => _userId = value;

  void setQuizId(int value) => _quizId = value;

  /// Stops the timer and calculates the time elapsed
  void stopTimer() {
    final DateTime now = DateTime.now();
    final int seconds = now.difference(_startTime).inSeconds;
    _timeElapsed = seconds;
  }

  Future<bool> sendScore() async {
    final double note = (_score / _total) * 20;
    printInfo(_timeElapsed.toString());
    final bool done = await saveNote(note, _userId, _quizId, _timeElapsed);
    return done;
  }

  @override
  String toString() {
    return 'QuizData{score: $_score,'
        ' total: $_total,'
        ' userId: $_userId,'
        ' quizId: $_quizId}'
        ' startTime: $_startTime'
    ;
  }
}