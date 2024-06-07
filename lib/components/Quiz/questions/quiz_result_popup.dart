import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show FontWeight, ImageFilter;
import 'package:my_quiz_ap/helpers/Colors.dart' show electricBlue;
import 'package:my_quiz_ap/helpers/utils.dart' show printInfo;

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
    printInfo("Note: $_note");
    return PopScope(
        canPop: true,
        child: Center(
          child: BlurryContainer(
            blur: 30,
            color: Colors.black.withOpacity(0.4),
            elevation: 15,
            shadowColor: electricBlue,
            borderRadius: BorderRadius.circular(20),
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.25,
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
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "$_note/20",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),

                  const Spacer(),

                  MaterialButton(
                    onPressed: () {
                      sendScore;
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },

                    color: electricBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
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
    barrierColor: const Color(0x00000000),
    builder: (context) => Stack(
      children: [

        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            )
        ),

        QuizResultPopup(
          score: score,
          total: total,
        ),
      ],
    ),
  );
}
