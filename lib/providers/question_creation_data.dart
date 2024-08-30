import 'package:flutter/cupertino.dart' show ChangeNotifier, FocusNode, TextEditingController;

/// Data used to create a question,
/// used in the [CreateQuestionPage]
class QuestionCreationData extends ChangeNotifier {

  /// Create a new [QuestionCreationData] object.
  /// Can be initialized with a [questionData] map.
  /// If [questionData] is null, it creates a new question with two propositions.
  /// If [focus] is true, it focuses the name field.
  QuestionCreationData({bool focus = true, Map<String,dynamic>? questionData}) {

    if (questionData == null) {  // create a new question with two propositions
      addProposition(text: '', isCorrect: true, focus: false);
      addProposition(text: '', isCorrect: false, focus: false);

      if (focus) {  // focus the name field
        Future.delayed(
            const Duration(milliseconds: 500),
            () => _nameFocusNode.requestFocus()
        );
      }
    } else {  // create a question from a map
      name = questionData['Question_text'];
      for (Map<String, dynamic> propositionData in questionData['Propositions']) {
        addProposition(
            text: propositionData['Proposition_text'],
            isCorrect: propositionData['Is_correct'],
            focus: false,
        );
      }
    }
  }

  String name = '';  // the question text
  int difficulty = 1;  // (deprecated but needed for the backend)

  final List<Proposition> _propositions = [];  // List of propositions
  final FocusNode _nameFocusNode = FocusNode();  // Focus node for the name field

  List<Proposition> get propositions => _propositions;
  FocusNode get nameFocusNode => _nameFocusNode;

  /// Add a new proposition to the question and notify listeners.
  /// If [text] is null, it creates an empty proposition.
  /// If [isCorrect] is null, it creates a false proposition.
  /// If [focus] is true, it focuses the new proposition.
  void addProposition({String? text, bool? isCorrect, bool focus = true}) {
    Proposition newProposition = Proposition(text ?? '', isCorrect ?? false);
    _propositions.add(newProposition);
    notifyListeners();

    if (focus) newProposition.focusNode.requestFocus();
  }

  /// Remove a proposition from the question and notify listeners.
  void removeProposition(int index) {
    _propositions.removeAt(index);
    notifyListeners();
  }

  @override
  String toString() {
    return '\t- QuestionCreationData{name: $name, difficulty: $difficulty, propositions:\n'
        '${_propositions.map((e) => e.toString()).join('\n')}';
  }
}


/// Proposition data for a question.
class Proposition {
  String text;  // the proposition text
  bool isCorrect;  // true if the proposition is correct

  // Controller and focus node for the proposition text field
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;

  /// Create a new [Proposition] object.
  /// Can be initialized with a [text] and an [isCorrect] value.
  Proposition(this.text, this.isCorrect) {
    _controller.text = text;
    isCorrect = isCorrect;
  }

  @override
  String toString() {
    return '\t\t- Proposition{text: $text, isCorrect: $isCorrect}';
  }
}