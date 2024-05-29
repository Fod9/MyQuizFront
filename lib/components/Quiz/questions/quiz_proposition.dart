import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

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
  late final isCorrect = widget.proposition['Is_correct'] == 'true';

  final Color _validColor = const Color(0xff37ae28);
  final Color _invalidColor = const Color(0xffe74c3c);
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

  void check() {
    if (isSelected || isCorrect) _controller.forward();
    setState(() {isSelected = false;});
    isLocked = true;
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
            AnimatedContainer(
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

            Positioned(
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
