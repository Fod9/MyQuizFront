import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/quiz/creation/questions/delete_question_btn.dart' show DeleteQuestionButton;
import 'package:my_quiz_ap/components/quiz/creation/questions/propositions/propostions_section.dart';
import 'package:my_quiz_ap/components/quiz/creation/questions/question_name_input.dart' show QuestionNameInput;
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;

class QuestionCreationBlock extends StatefulWidget {
  const QuestionCreationBlock({
    super.key,
    required this.questionIndex,
  });

  final int questionIndex;

  @override
  State<QuestionCreationBlock> createState() => QuestionCreationBlockState();
}

class QuestionCreationBlockState extends State<QuestionCreationBlock> {

  final GlobalKey<QuestionCreationBlockState> _questionBlockKey = GlobalKey<QuestionCreationBlockState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: _questionBlockKey,
      padding: const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: lightGlass,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: -7.5,
              offset: Offset(0, 7.5),
            ),
          ],
        ),

        child: Stack(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minHeight: 450,
                  maxWidth: 600,
              ),

              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    QuestionNameInput(),

                    SizedBox(height: 32.0),

                    PropositionsSection(),
                  ],
                ),
              ),
            ),

            DeleteQuestionButton(widget.questionIndex, questionBlockKey: _questionBlockKey),
          ],
        ),
      ),
    );
  }
}
