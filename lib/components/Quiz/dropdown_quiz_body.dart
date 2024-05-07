import 'package:flutter/material.dart';

class DropdownQuizBody extends StatefulWidget {
  const DropdownQuizBody({
    super.key,
    required this.width,
    required this.height,
    required this.quizList,
  });

  final double width, height;
  final List<Map<String, dynamic>> quizList;

  @override
  State<DropdownQuizBody> createState() => DropdownQuizBodyState();
}

class DropdownQuizBodyState extends State<DropdownQuizBody>
  with SingleTickerProviderStateMixin {

  late double currentHeight = 0;
  final Duration _animationDuration = const Duration(milliseconds: 250);

  late final AnimationController _controller = AnimationController(
    duration: _animationDuration,
    vsync: this,
  )..addListener(() {
    setState(() {
      currentHeight = _animation.value;
    });
  });

  late final CurvedAnimation _animationCurve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  late final Animation<double> _animation = Tween<double>(
    begin: 0,
    end: widget.height,
  ).animate(_animationCurve);

  void toggleExpand() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: currentHeight,
    );
  }
}
