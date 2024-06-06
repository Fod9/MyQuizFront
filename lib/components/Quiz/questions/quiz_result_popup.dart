import 'package:flutter/material.dart';
import 'dart:ui' show FontWeight, ImageFilter;

class QuizResultPopup extends StatefulWidget {
  const QuizResultPopup({
    super.key,
    required this.score,
    required this.total
  });

  final int score;
  final int total;

  @override
  State<QuizResultPopup> createState() => _QuizResultPopupState();
}

class _QuizResultPopupState extends State<QuizResultPopup> {

  late final double _note = widget.score / widget.total * 20;

  void sendScore() async {
    // TODO Send the score to the server
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: -7.5,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    "Votre note est de $_note/20",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  ElevatedButton(
                    onPressed: sendScore,
                    child: const Text(
                      "Envoyer la note",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        )
    );
  }
}

void displayResultPopup(
    BuildContext context, {
      required int score,
      required int total
    }) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: const Color(0x10000000),
    builder: (context) => Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),

        QuizResultPopup(
          score: score,
          total: total,
        ),
      ],
    ),
  );
}
