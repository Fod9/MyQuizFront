import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:my_quiz_ap/providers/question_creation_data.dart' show QuestionCreationData;

class QuizCreationData extends ChangeNotifier {

  QuizCreationData() {
    printOrder("QuizCreationData constructor called");

    // add initial question when creating a quiz
    addQuestion(QuestionCreationData(focus: false));
  }

  String _quizName = '';
  Map<String, dynamic>? _selectedSubject, _selectedClass;
  int _userId = -1;
  int? quizId;  // used only if modifying a quiz
  final List<QuestionCreationData> _questions = [];

  String get quizName => _quizName;
  Map<String, dynamic>? get selectedSubject => _selectedSubject;
  Map<String, dynamic>? get selectedClass => _selectedClass;
  int get userId => _userId;
  List<QuestionCreationData> get questions => _questions;

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

  void addQuestion(QuestionCreationData question) {
    _questions.add(question);
    notifyListeners();
  }

  void removeQuestion(int index) {
    _questions.removeAt(index);
    notifyListeners();
  }

  void setQuizData(Map<String, dynamic> quizData) {
    printInfo(quizData.toString());
    quizId = quizData['Quiz_id'];
    _quizName = quizData['Quiz_name'];

    _questions.clear();
    for (Map<String, dynamic> questionData in quizData['Questions']) {
      addQuestion(QuestionCreationData(questionData: questionData));
    }
    notifyListeners();
  }

  @override
  String toString() {
    return "QuizCreationData:\n"
    "- quizName: $_quizName\n"
    "- selectedSubject: $_selectedSubject,\n"
    "- selectedClass: $_selectedClass,\n"
    "- userId: $_userId\n"
    "- questions:\n"
        "${_questions.map((e) => e.toString()).join('\n')}";
  }
}