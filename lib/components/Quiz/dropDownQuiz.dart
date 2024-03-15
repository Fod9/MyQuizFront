import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/sizedBlock.dart';


class DropDownQuiz extends StatefulWidget {
  const DropDownQuiz({super.key, required this.height, required this.width, required this.matiereName});

  final String matiereName;
  final double height;
  final double width;

  @override
  State<DropDownQuiz> createState() => _DropDownQuizState();
}

class _DropDownQuizState extends State<DropDownQuiz> with TickerProviderStateMixin {

  late AnimationController _controller;
  late AnimationController _expandController;

  List<Animation<double>> _opacityAnimations = [];
  List<Animation<Offset>> _translateAnimations = [];


  bool _isExpanded = false;

  final int numberOfElements = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2 ), // Durée réduite pour une réactivité accrue
      vsync: this,
    );

    _expandController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Initialize the animations with adjusted intervals
    for (int i = 0; i < numberOfElements; i++) {
      final startInterval = i / numberOfElements;
      final endInterval = (i + 1) / numberOfElements;

      _opacityAnimations.add(Tween<double>(begin: 0.0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            startInterval, endInterval,
            curve: Curves.linear, // Courbe plus réactive
          ),
        ),
      ));

      _translateAnimations.add(Tween<Offset>(
        begin: const Offset(0, -0.5),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            startInterval, endInterval,
            curve: Curves.linear, // Courbe plus réactive
          ),
        ),
      ));
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void startAnimation() {
    _expandController.forward();
    _controller.forward();
    _isExpanded = true;
  }


  void startAnimationOut() {
    _controller.reverse().whenComplete(() =>
      _expandController.reverse()
    );
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {

    List<String> quizList = ["Quiz 1", "Quiz 2", "Quiz 3"];

    return Column(
      children: [
        SizedBlock(
            height: widget.height,
            width: widget.width,
            matiereName: widget.matiereName,
            isExpanded: false,
            isExpendable: true,
            expandController: _expandController,
            clickEvent: () {
              if (_isExpanded) {
                startAnimationOut();
              } else {
                startAnimation();
              }
            }
        ),
        // loop through the quizList and create a MatiereBlock for each quiz
        Column(
          children: quizList.asMap().entries.map((entry) {
            int idx = entry.key; // Correctly captured index
            String quiz = entry.value;

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Visibility(
                  visible: _opacityAnimations[idx].value > 0,
                  child: Opacity(
                    opacity: _opacityAnimations[idx].value,
                    child: Transform.translate(
                      offset: _translateAnimations[idx].value,
                      child: SizedBlock(
                        clickEvent: () {},
                        height: widget.height,
                        width: widget.width,
                        matiereName: quiz,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
