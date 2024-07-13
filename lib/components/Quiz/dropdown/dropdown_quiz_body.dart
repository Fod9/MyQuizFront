import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown/add_quiz_button.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown/dropdown_quiz_btn.dart';
import 'package:my_quiz_ap/helpers/utils.dart';

class DropdownQuizBody extends StatefulWidget {
  const DropdownQuizBody({
    super.key,
    required this.width,
    required this.height,
    required this.quizList,
    required this.subject,
    required this.isTeacher,
  });

  final double width, height;
  final List<Map<String, dynamic>> quizList;
  final String subject;
  final bool isTeacher;

  @override
  State<DropdownQuizBody> createState() => DropdownQuizBodyState();
}

class DropdownQuizBodyState extends State<DropdownQuizBody>
  with SingleTickerProviderStateMixin {

  final double quizBtnHeight = 50;
  late double currentHeight = 0;
  final Duration _animationDuration = const Duration(milliseconds: 250);

  late String currentRoute = ModalRoute.of(context)?.settings.name ?? '';
  late bool isTeacherRoute = currentRoute == '/teacher';

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
    end: (quizBtnHeight + 20) * widget.quizList.length + (isTeacherRoute ? 75 : 0),
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
          width: widget.width * 0.75 - (widget.isTeacher ? 18 : 0) ,
          isTeacher: widget.isTeacher,
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

            if (isTeacherRoute) AddQuizButton(widget.subject),
          ],
        ),
      ),
    );
  }
}
