import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show QuestionCreationData;

/// Data used to create a quiz in the quiz creation page
/// It can be initialized with a quiz data to modify a quiz
/// using the [setQuizData] method
class QuizCreationData extends ChangeNotifier {

  /// Initializes a new quiz creation data with an empty question
  QuizCreationData() {
    // add initial question when creating a quiz
    addQuestion(QuestionCreationData(focus: false));
  }

  String quizName = '';  // quiz name
  Map<String, dynamic>? _selectedSubject;  // selected subject
  final List<Map<String, dynamic>> _selectedClasses = [];  // list of selected classes
  int userId = -1;  // id of the user creating the quiz
  int? quizId;  // used only if modifying a quiz
  final List<QuestionCreationData> _questions = [];

  Map<String, dynamic>? get selectedSubject => _selectedSubject;
  List<Map<String, dynamic>> get selectedClasses => _selectedClasses;
  List<QuestionCreationData> get questions => _questions;

  /// Sets the quiz corresponding subject (matiere) and notify listeners
  void setSelectedSubject(Map<String, dynamic> subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  /// Adds a class to the selected classes list and notify listeners
  void addClass(Map<String, dynamic> class_) {
    _selectedClasses.add(class_);
    notifyListeners();
  }

  /// Removes a class from the selected classes list and notify listeners
  void removeClass(Map<String, dynamic> class_) {
    _selectedClasses.remove(class_);
    notifyListeners();
  }

  /// Adds a question to the questions list and notify listeners
  void addQuestion(QuestionCreationData question) {
    _questions.add(question);
    notifyListeners();
  }

  /// Removes a question from the questions list and notify listeners
  void removeQuestion(int index) {
    _questions.removeAt(index);
    notifyListeners();
  }

  /// Sets the quiz data,
  /// used when modifying a quiz
  void setQuizData(Map<String, dynamic> quizData) {
    quizId = quizData['Quiz_id'];
    quizName = quizData['Quiz_name'];
    // _selectedSubject = quizData['Matiere'];
    // _selectedClass = quizData['Classes'][0];
    // TODO ADD class and subject

    _questions.clear();
    for (Map<String, dynamic> questionData in quizData['Questions']) {
      addQuestion(QuestionCreationData(questionData: questionData));
    }
    notifyListeners();
  }

  @override
  String toString() {
    return "QuizCreationData:\n"
    "- quizName: $quizName\n"
    "- selectedSubject: $_selectedSubject,\n"
    "- selectedClass: $_selectedClasses,\n"
    "- userId: $userId\n"
    "- questions:\n"
        "${_questions.map((e) => e.toString()).join('\n')}";
  }
}