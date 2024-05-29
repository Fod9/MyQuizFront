import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class QuizProposition extends StatefulWidget {
  const QuizProposition({
    super.key,
    required this.proposition,
    required this.index,
  });

  final Map<String, dynamic> proposition;
  final int index;

  @override
  State<QuizProposition> createState() => QuizPropositionState();
}

class QuizPropositionState extends State<QuizProposition> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        child: Stack(
          children: [
            MaterialButton(
              onPressed: () {
                // TODO check answer
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,

              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),

              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.proposition['Proposition_text']!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              top: 1,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: electricBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
                  child: Text(
                    widget.index.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              )
            ),
          ],
        )
    );
  }
}
