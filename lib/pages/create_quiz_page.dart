import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/create_quiz_button.dart';
import 'package:my_quiz_ap/components/Quiz/creation/quiz_name_input.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:my_quiz_ap/providers/quiz_creation_data.dart';
import 'package:provider/provider.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => QuizCreationData(),
      child: PopScope(
        onPopInvoked: (_) {
          // TODO : unFocus all text fields
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: QuizNameInput(),
              ),

              CreateQuizButton(),
            ],
          ),
        ),
      ),
    );
  }
}
