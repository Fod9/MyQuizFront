import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';


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
  });

  final Function() onPressed;
  final PageController pageController;

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
          widget.onPressed();
          if (!_isNext) {
            setState(() {_isNext = true;});
          } else {
            widget.pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
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
