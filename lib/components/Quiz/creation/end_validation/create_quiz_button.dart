import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/end_validation/create_quiz_popup.dart' show displayCreateQuizPopup;
import 'package:my_quiz_ap/helpers/Colors.dart' show electricBlue;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show Provider;

class CreateQuizButton extends StatefulWidget {
  const CreateQuizButton({super.key});

  @override
  State<CreateQuizButton> createState() => _CreateQuizButtonState();
}

class _CreateQuizButtonState extends State<CreateQuizButton> {

  // TODO add pop-up dialog to confirm quiz creation

  late final _provider = Provider.of<QuizCreationData>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => displayCreateQuizPopup(context, _provider),

      color: electricBlue.withOpacity(0.5),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),

      child: const Text(
        'Create Quiz',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
