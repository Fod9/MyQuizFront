import 'package:flutter/material.dart';
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show Provider;

class SelectSubjectClassPopup extends StatefulWidget {
  const SelectSubjectClassPopup({
    super.key,
    required this.listOfSelections,
    required this.title,
    this.selectedValue,
  });

  final List<dynamic> listOfSelections;
  final String title;
  final String? selectedValue;

  @override
  State<SelectSubjectClassPopup> createState() => _SelectSubjectClassPopupState();
}

class _SelectSubjectClassPopupState extends State<SelectSubjectClassPopup> {

  late final QuizCreationData _provider = Provider.of<QuizCreationData>(context);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

