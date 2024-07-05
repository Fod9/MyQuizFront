import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/questions/question_creation_block.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:my_quiz_ap/helpers/Colors.dart' show invalidColor;
import 'package:my_quiz_ap/providers/layout_provider.dart' show LayoutProvider;

class DeleteQuestionButton extends StatefulWidget {
  const DeleteQuestionButton(
      this.questionIndex,{
        super.key,
        required this.questionBlockKey,
      });

  final int questionIndex;
  final GlobalKey<QuestionCreationBlockState> questionBlockKey;

  @override
  State<DeleteQuestionButton> createState() => _DeleteQuestionButtonState();
}

class _DeleteQuestionButtonState extends State<DeleteQuestionButton> {

  late final QuizCreationData _quizProvider = Provider.of<QuizCreationData>(context, listen: false);
  late final _layoutProvider = Provider.of<LayoutProvider>(context, listen: false);

  final double _size = 44.0;
  final double? _elevation = null;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,

      child: SizedBox(
        width: _size,
        height: _size,
        child: MaterialButton(
          onPressed: () {

            final RenderBox renderBox = widget.questionBlockKey.currentContext!.findRenderObject() as RenderBox;
            final Size size = renderBox.size;
            final double height = size.height;

            printInfo(height.toString());

            _layoutProvider.scrollUp(height);

            Future.delayed(const Duration(milliseconds: 300), () {
              _quizProvider.removeQuestion(widget.questionIndex);
            });
          },

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),

          color: invalidColor,

          elevation: _elevation,
          focusElevation: _elevation,
          hoverElevation: _elevation,
          highlightElevation: _elevation,

          padding: EdgeInsets.zero,


          child: const Icon(
            Icons.delete_rounded,
            color: Colors.white,

          ),
        ),
      ),
    );
  }
}
