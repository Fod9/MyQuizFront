import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/questions/delete_question_btn.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;
import 'package:my_quiz_ap/providers/question_creation_data.dart';
import 'package:provider/provider.dart';

class QuestionCreationBlock extends StatefulWidget {
  const QuestionCreationBlock({
    super.key,
    required this.questionIndex,
  });

  final int questionIndex;

  @override
  State<QuestionCreationBlock> createState() => _QuestionCreationBlockState();
}

class _QuestionCreationBlockState extends State<QuestionCreationBlock> {

  late final QuestionCreationData _questionProvider = Provider.of<QuestionCreationData>(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
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
            SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              height: 450,
            ),

            DeleteQuestionButton(widget.questionIndex),
          ],
        ),
      ),
    );
  }
}
