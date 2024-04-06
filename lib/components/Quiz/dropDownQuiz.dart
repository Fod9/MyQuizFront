import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Globals/AddButton.dart';
import 'package:my_quiz_ap/components/sizedBlock.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class DropDownQuiz extends StatefulWidget {
  const DropDownQuiz(
      {super.key,
      required this.height,
      required this.width,
      required this.blockName,
      this.mode = "student"});

  final String blockName;
  final double height;
  final double width;
  final String mode;

  @override
  State<DropDownQuiz> createState() => _DropDownQuizState();
}

class _DropDownQuizState extends State<DropDownQuiz>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _expandController;
  late final AnimationController _buttonController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  List<Animation<double>> _opacityAnimations = [];
  List<Animation<Offset>> _popAnimations = [];
  late Animation<double> _buttonAnimation;
  double containerHeight = 0;

  bool _isExpanded = false;

  final int numberOfElements = 3;
  Duration? calculatedDuration;
  double calculatedHeight = 0;

  @override
  void initState() {
    super.initState();

    int numberOfElements = 3;
    setState(() {
      calculatedDuration = Duration(milliseconds: 350 * numberOfElements);
      calculatedHeight =
          (widget.height * (numberOfElements) + widget.height) * 0.9;
    });

    _controller = AnimationController(
      duration: Duration(seconds: calculatedDuration!.inSeconds),
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
            startInterval,
            endInterval,
            curve: Curves.linear,
          ),
        ),
      ));

      _popAnimations.add(Tween<Offset>(
        begin: const Offset(0, -0.5),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            startInterval,
            endInterval,
            curve: Curves.linear,
          ),
        ),
      ));
    }

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void startAnimation() {
    _expandController.forward();
    _controller.forward();
    _isExpanded = true;

    Future.delayed(_controller.duration!, () {
      _buttonController.forward();
    });
    setState(() {
      print(calculatedHeight);
      containerHeight = calculatedHeight;
    });
  }

  void startAnimationOut() {
    Duration? delay = Duration(milliseconds: 100 * numberOfElements);
    _buttonController.reverse();
    _expandController.reverse();
    _controller.reverse();
    _isExpanded = false;
    setState(() {
      containerHeight = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> quizList = ["Quiz 1", "Quiz 2", "Quiz 3"];

    return Column(
      children: [
        SizedBlock(
            height: widget.height,
            width: widget.width,
            blockName: widget.blockName,
            isExpanded: false,
            isExpendable: true,
            expandController: _expandController,
            hasShadow: true,
            clickEvent: () {
              if (_isExpanded) {
                startAnimationOut();
              } else {
                startAnimation();
              }
            }),
        // loop through the quizList and create a MatiereBlock for each quiz
        Column(
          children: [
            AnimatedContainer(
              duration: (_isExpanded)
                  ? Duration(milliseconds: 300 * numberOfElements)
                  : Duration(milliseconds: 300 * numberOfElements),
              height: containerHeight,
              child: Column(children: [
                ...quizList.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String quiz = entry.value;

                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Visibility(
                        visible: _opacityAnimations[idx].value > 0,
                        child: Opacity(
                          opacity: _opacityAnimations[idx].value,
                          child: Transform.scale(
                            scale: _opacityAnimations[idx].value,
                            child: SizedBlock(
                              clickEvent: () {},
                              height: widget.height * 0.7,
                              width: widget.width * 0.9,
                              blockName: quiz,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                (widget.mode == "teacher")
                    ? AnimatedBuilder(
                        animation: _buttonController,
                        builder: (context, child) {
                          return Visibility(
                            visible: _buttonAnimation.value > 0,
                            child: Opacity(
                              opacity: _buttonAnimation.value,
                              child: Transform.scale(
                                scale: _buttonAnimation.value,
                                child: AddButton(
                                  width: widget.width * 0.9,
                                  color: lightGreen,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
