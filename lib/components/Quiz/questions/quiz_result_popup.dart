import 'package:flutter/material.dart';
import 'dart:ui' show FontWeight, ImageFilter;

import 'package:my_quiz_ap/helpers/Colors.dart';

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
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(30),
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
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Column(
                          children: [
                            const Text(
                              "Vous avez obtenu",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "$_note/20",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),

                        const Spacer(),

                        MaterialButton(
                          onPressed: sendScore,
                          color: electricBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "Terminer le quiz",
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
                ),
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
    barrierColor: const Color(0x60000000),
    builder: (context) => QuizResultPopup(
      score: score,
      total: total,
    ),
  );
}
