import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
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
    return ElevatedButton(  // TODO : change to custom button
      onPressed: () {
        printInfo(_provider.toString());
      },

      child: const Text('Print Quiz Data'),
    );
  }
}
