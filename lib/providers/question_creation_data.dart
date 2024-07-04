import 'package:flutter/cupertino.dart' show ChangeNotifier, TextEditingController;

class QuestionCreationData extends ChangeNotifier {

  QuestionCreationData() {
    addProposition(text: '', isCorrect: true);
    addProposition(text: '', isCorrect: false);
  }

  String name = '';
  int difficulty = 1;

  final List<Proposition> _propositions = [];

  List<Proposition> get propositions => _propositions;

  void addProposition({String? text, bool? isCorrect}) {
    _propositions.add(Proposition(text ?? '', isCorrect ?? false));
    notifyListeners();
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

  TextEditingController get controller => _controller;

  Proposition(this.text, this.isCorrect);

  @override
  String toString() {
    return '\t\t- Proposition{text: $text, isCorrect: $isCorrect}';
  }
}