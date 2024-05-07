import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Globals/AddButton.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown_quiz.dart';
import 'package:my_quiz_ap/components/Stats/Statistics.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key, required this.screenType});

  final String screenType;

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  double _width = 300;
  double _height = 150;

  final List<Map<String, dynamic>> _blocList = [
    {
      "name": "Maths",
      "id": "1",
      "QuizList": [
        {"name": "Math Quiz 1", "id": "1"},
        {"name": "Math Quiz 2", "id": "2"},
        {"name": "Math Quiz 3", "id": "3"}
      ]
    },
    {
      "name": "Physics",
      "id": "2",
      "QuizList": [
        {"name": "Physics Quiz 1", "id": "1"},
        {"name": "Physics Quiz 2", "id": "2"},
        {"name": "Physics Quiz 3", "id": "3"}
      ]
    },
    {
      "name": "Chemistry",
      "id": "3",
      "QuizList": [
        {"name": "Chemistry Quiz 1", "id": "1"},
        {"name": "Chemistry Quiz 2", "id": "2"},
        {"name": "Chemistry Quiz 3", "id": "3"}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == "mobile" ) {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return (widget.screenType == "mobile" || _width > 600)
        ? MobileDisplay(
          width: _width,
          height: _height,
          blocList: _blocList,
        )
        : DesktopDisplay(
          width: _width,
          height: _height
        );
  }
}

//create a widget
class MobileDisplay extends StatelessWidget {
  const MobileDisplay({
    super.key,
    required this.width,
    required this.height,
    required this.blocList,
  });

  final double width;
  final double height;
  final List<Map<String, dynamic>> blocList;

  Iterable<Widget> get _blocWidgets sync* {
    for (var bloc in blocList) {
      yield DropDownQuiz(
        blockName: bloc["name"],
        height: height,
        width: width,
        mode: "teacher",
        quizList: bloc["QuizList"],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ..._blocWidgets
        ],
      ),
    );
  }
}

class DesktopDisplay extends StatelessWidget {
  const DesktopDisplay({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [

            ],
          ),
        ],
      ),
    );
  }
}
