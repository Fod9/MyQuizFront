import 'package:flutter/cupertino.dart';

class QuizCreationData extends ChangeNotifier {
  String _quizName = '';

  String get quizName => _quizName;

  void setQuizName(String quizName) => _quizName = quizName;
}