import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/providers/layout_provider.dart' show LayoutProvider;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show QuestionCreationData;
import 'package:provider/provider.dart' show Provider;

class AddPropositionButton extends StatefulWidget {
  const AddPropositionButton({super.key});

  @override
  State<AddPropositionButton> createState() => _AddPropositionButtonState();
}

class _AddPropositionButtonState extends State<AddPropositionButton> {

  late final _questionProvider = Provider.of<QuestionCreationData>(context, listen: false);
  late final _layoutProvider = Provider.of<LayoutProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          _questionProvider.addProposition();
          _layoutProvider.scrollDown(65.0);
        },

        color: lightGlassBlue,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        child: const Text(
          '+ Add proposition',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
    );
  }
}
