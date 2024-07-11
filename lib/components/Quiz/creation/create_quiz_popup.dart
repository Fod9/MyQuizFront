import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:blurrycontainer/blurrycontainer.dart' show BlurryContainer;
import 'package:my_quiz_ap/helpers/Colors.dart' show electricBlue, lightGlass;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;

class _CreateQuizPopup extends StatefulWidget {
  const _CreateQuizPopup(this.quizData, {super.key});

  final QuizCreationData quizData;

  @override
  State<_CreateQuizPopup> createState() => _CreateQuizPopupState();
}

class _CreateQuizPopupState extends State<_CreateQuizPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlurryContainer(
        borderRadius: BorderRadius.circular(20),
        color: lightGlass,
        elevation: 15,
        blur: 30,
        padding: const EdgeInsets.all(20),
        width: (MediaQuery.of(context).size.width * 0.8).clamp(0, 500),
        height: 500,
        shadowColor: electricBlue.withOpacity(0.5),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}


void displayCreateQuizPopup(BuildContext context, QuizCreationData quizData) {
  showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                )
            ),

            _CreateQuizPopup(quizData),
          ],
        );
      }
  );
}
