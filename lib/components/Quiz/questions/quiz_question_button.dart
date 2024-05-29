import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class QuizQuestionButton extends StatefulWidget {
  const QuizQuestionButton({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  State<QuizQuestionButton> createState() => _QuizQuestionButtonState();
}

class _QuizQuestionButtonState extends State<QuizQuestionButton>
    with AutomaticKeepAliveClientMixin {

  final TextStyle _style = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: "Quicksand",
    fontWeight: FontWeight.w600,
  );

  bool _isNext = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 50,
      width: 150,
      child: MaterialButton(
        onPressed: () {
          widget.onPressed();
          if (!_isNext) {
            setState(() {_isNext = true;});
          } else {
            // TODO NAVIGATE TO NEXT QUESTION
          }
        },
        color: electricBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedCrossFade(
            firstChild: SizedBox(
              width: 150,
              child: Text(
                "Valider",
                textAlign: TextAlign.center,
                style: _style,
              ),
            ),
            
            secondChild: SizedBox(
              width: 150,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Suivant",
                    style: _style,
                  ),

                  const SizedBox(width: 10),

                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
            crossFadeState: _isNext ?
              CrossFadeState.showSecond
                :
              CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
