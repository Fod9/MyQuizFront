import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/quiz/creation/questions/add_question_btn.dart' show AddQuestionButton;
import 'package:my_quiz_ap/components/quiz/creation/questions/question_creation_block.dart' show QuestionCreationBlock;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show QuestionCreationData;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;

class QuestionsSection extends StatefulWidget {
  const QuestionsSection({super.key});

  @override
  State<QuestionsSection> createState() => _QuestionsSectionState();
}

class _QuestionsSectionState extends State<QuestionsSection> {

  late final QuizCreationData _quizCreationData = Provider.of<QuizCreationData>(context);
  late final List<QuestionCreationData> questions = _quizCreationData.questions;

  void _addQuestion() {
    _quizCreationData.addQuestion(QuestionCreationData());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        for (int i = 0; i < questions.length; i++)
          ChangeNotifierProvider.value(  // fixes deletion issue
            value: questions[i],
            child: QuestionCreationBlock(
              key: UniqueKey(),  // unique key for updating the widget each refresh
              questionIndex: i,
            ),
          ),

        AddQuestionButton(_addQuestion),
      ],
    );
  }
}
