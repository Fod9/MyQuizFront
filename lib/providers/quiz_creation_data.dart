import 'package:flutter/cupertino.dart';

class QuizCreationData extends ChangeNotifier {
  String _quizName = '';
  String? _selectedSubject;
  String? _selectedClass;

  String get quizName => _quizName;
  String? get selectedSubject => _selectedSubject;
  String? get selectedClass => _selectedClass;

  void setQuizName(String quizName) => _quizName = quizName;

  void setSelectedSubject(String subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  void setSelectedClass(String class_) {
    _selectedClass = class_;
    notifyListeners();
  }
}