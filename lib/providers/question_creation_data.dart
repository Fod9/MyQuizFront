import 'package:flutter/cupertino.dart' show ChangeNotifier;

class QuestionCreationData extends ChangeNotifier {
  String name = '';
  int difficulty = 1;

  final List<Proposition> _propositions = [];

  void addProposition(String text, bool isCorrect) {
    _propositions.add(Proposition(text, isCorrect));
    notifyListeners();
  }

  void removeProposition(int index) {
    _propositions.removeAt(index);
    notifyListeners();
  }
}

class Proposition {
  String text;
  bool isCorrect;

  Proposition(this.text, this.isCorrect);
}