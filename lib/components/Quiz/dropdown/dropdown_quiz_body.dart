import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown/dropdown_quiz_btn.dart';

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

  final double quizBtnHeight = 50;
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
    end: (quizBtnHeight + 20) * widget.quizList.length,
  ).animate(_animationCurve);

  void toggleExpand() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  Iterable<Widget> getQuizList() sync* {
    for (var quiz in widget.quizList) {
      yield DropdownQuizButton(
          quizName: quiz['name']!,
          quizId: quiz['id']!,
          height: quizBtnHeight,
          width: widget.width * 0.75,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: currentHeight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            ...getQuizList(),
          ],
        ),
      ),
    );
  }
}
