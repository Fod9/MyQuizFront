import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/colors.dart' show electricBlue, invalidColor, validColor;


/// A widget that displays a quiz proposition.
/// The proposition is a button that can be selected (outlined).
/// The proposition can be locked after the user has validated the answer.
/// The proposition can be highlighted with a color (green or red) if it is correct or not.
///
/// params:
/// - [Map<String, dynamic>] [proposition]
/// - [Function()] [onPressed]
/// - [int] [index]
class QuizProposition extends StatefulWidget {
  const QuizProposition({
    super.key,
    required this.proposition,
    required this.onPressed,
    required this.index,
  });

  final Map<String, dynamic> proposition;
  final Function() onPressed;
  final int index;

  @override
  State<QuizProposition> createState() => QuizPropositionState();
}

class QuizPropositionState extends State<QuizProposition>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  bool isSelected = false;
  bool isLocked = false;
  late final isCorrect = widget.proposition['Is_correct'];

  // colors for highlighting the proposition
  final Color _validColor = validColor;
  final Color _invalidColor = invalidColor;
  late final Color _highlightColor = (isCorrect) ?
    _validColor : _invalidColor;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..addListener(() {
    setState(() {});
  });

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  /// Check if the proposition is correct or not.
  /// Called from the parent widget.
  /// If the proposition is selected, return true.
  bool check() {
    if (isSelected || isCorrect) _controller.forward();

    final bool result = isSelected;

    setState(() {isSelected = false;});
    isLocked = true;

    return result;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        child: Stack(
          children: [
            AnimatedContainer(  // animated outline for selection
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? electricBlue : Colors.transparent,
                  width: 5,
                ),
              ),
              child: MaterialButton(
                onPressed: isLocked ? null : () {
                  if (!isLocked) setState(() {isSelected = !isSelected;});
                  widget.onPressed();
                },
                // color depending if the proposition is correct or not
                color: Color.lerp(Colors.white, _highlightColor, _animation.value)!,
                disabledColor: Color.lerp(Colors.white, _highlightColor, _animation.value)!,
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
                    style: TextStyle(
                      color: Color.lerp(Colors.black, Colors.white, _animation.value)!,
                      fontSize: 18,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(  // displayed index of the proposition
              left: 0,
              top: 0,
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

  @override
  bool get wantKeepAlive => true;
}
