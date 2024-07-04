import 'package:flutter/cupertino.dart';

class QuizCreationData extends ChangeNotifier {
  String _quizName = '';
  Map<String, dynamic>? _selectedSubject, _selectedClass;
  int _userId = -1;

  String get quizName => _quizName;
  Map<String, dynamic>? get selectedSubject => _selectedSubject;
  Map<String, dynamic>? get selectedClass => _selectedClass;
  int get userId => _userId;

  void setQuizName(String quizName) => _quizName = quizName;

  void setSelectedSubject(Map<String, dynamic> subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  void setSelectedClass(Map<String, dynamic> class_) {
    _selectedClass = class_;
    notifyListeners();
  }

  void setUserId(int userId) => _userId = userId;

  @override
  String toString() {
    return "QuizCreationData:\n"
    "- quizName: $_quizName\n"
    "- selectedSubject: $_selectedSubject,\n"
    "- selectedClass: $_selectedClass,\n"
    "- userId: $_userId";
  }
}