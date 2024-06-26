import 'package:flutter/cupertino.dart';

class QuizCreationData extends ChangeNotifier {
  String _quizName = '';
  Map<String, dynamic>? _selectedSubject, _selectedClass;

  String get quizName => _quizName;
  Map<String, dynamic>? get selectedSubject => _selectedSubject;
  Map<String, dynamic>? get selectedClass => _selectedClass;

  void setQuizName(String quizName) => _quizName = quizName;

  void setSelectedSubject(Map<String, dynamic> subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  void setSelectedClass(Map<String, dynamic> class_) {
    _selectedClass = class_;
    notifyListeners();
  }

  @override
  String toString() {
    return "QuizCreationData:\n"
    "- quizName: $_quizName\n"
    "- selectedSubject: $_selectedSubject,\n"
    "- selectedClass: $_selectedClass,\n";
  }
}