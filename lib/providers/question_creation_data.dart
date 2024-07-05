import 'package:flutter/cupertino.dart' show ChangeNotifier, FocusNode, TextEditingController;

class QuestionCreationData extends ChangeNotifier {

  QuestionCreationData({bool focus = true}) {
    addProposition(text: '', isCorrect: true, focus: false);
    addProposition(text: '', isCorrect: false, focus: false);

    if (focus) {
      Future.delayed(
          const Duration(milliseconds: 500),
          () => _nameFocusNode.requestFocus()
      );
    }
  }

  String name = '';
  int difficulty = 1;

  final List<Proposition> _propositions = [];
  final FocusNode _nameFocusNode = FocusNode();

  List<Proposition> get propositions => _propositions;
  FocusNode get nameFocusNode => _nameFocusNode;

  void addProposition({String? text, bool? isCorrect, bool focus = true}) {
    Proposition newProposition = Proposition(text ?? '', isCorrect ?? false);
    _propositions.add(newProposition);
    notifyListeners();

    if (focus) newProposition.focusNode.requestFocus();
  }

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

class Proposition {
  String text;
  bool isCorrect;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;

  Proposition(this.text, this.isCorrect);

  @override
  String toString() {
    return '\t\t- Proposition{text: $text, isCorrect: $isCorrect}';
  }
}