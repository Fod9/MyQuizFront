import 'package:flutter/material.dart';


class QuizQuestionBlock extends StatefulWidget {
  const QuizQuestionBlock({
    super.key,
    required this.question,
  });

  final Map<String, dynamic> question;

  @override
  State<QuizQuestionBlock> createState() => _QuizQuestionBlockState();
}

class _QuizQuestionBlockState extends State<QuizQuestionBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
      )
    );
  }
}
