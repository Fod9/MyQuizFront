import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_result_popup.dart' show displayResultPopup;
import 'package:my_quiz_ap/helpers/Colors.dart' show electricBlue;
import 'package:provider/provider.dart' show Provider;
import 'package:my_quiz_ap/providers/quiz_data.dart' show QuizData;


/// Button to validate the current quiz question
/// Once the button is pressed, it will change to a "next" button
///
/// The button is disabled by default and can be enabled by calling the [enable] method
/// It is enabled only if at least 1 proposition is selected
class QuizQuestionButton extends StatefulWidget {
  const QuizQuestionButton({
    super.key,
    required this.onPressed,
    required this.pageController,
    this.isLast = false,
  });

  final Function() onPressed;
  final PageController pageController;
  final bool isLast;

  @override
  State<QuizQuestionButton> createState() => QuizQuestionButtonState();
}

class QuizQuestionButtonState extends State<QuizQuestionButton>
    with AutomaticKeepAliveClientMixin {

  // Text that will be displayed on the button
  final TextStyle _style = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: "Quicksand",
    fontWeight: FontWeight.w600,
  );

  bool _isNext = false;
  bool _isEnabled = false;


  /// Enables the button
  /// Usually called from the parent widget
  void enable() {
    setState(() {_isEnabled = true;});
  }

  /// Disables the button
  /// Usually called from the parent widget
  void disable() {
    setState(() {_isEnabled = false;});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 50,
      width: 150,
      child: MaterialButton(
        onPressed: !_isEnabled ? null :  () {
          if (!_isNext) {
            widget.onPressed();
            setState(() {_isNext = true;});
          } else {
            if (widget.isLast) {

              final int score = Provider.of<QuizData>(context, listen: false).score;
              final total = Provider.of<QuizData>(context, listen: false).total;

              displayResultPopup(
                context,
                score: score,
                total: total,
                sendScore: Provider.of<QuizData>(context, listen: false).sendScore,
              );
            } else {
              widget.pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        color: electricBlue,
        disabledColor: Colors.grey[600],
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
                    widget.isLast ? "Terminer" : "Suivant",
                    style: _style,
                  ),

                  const SizedBox(width: 10),

                  Icon(
                    widget.isLast ?
                      Icons.done_rounded : Icons.arrow_forward_ios_rounded,
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
