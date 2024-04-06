import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Globals/AddButton.dart';
import 'package:my_quiz_ap/components/Quiz/dropDownQuiz.dart';
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

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == "mobile" ) {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return (widget.screenType == "mobile" || _width > 600)
        ? MobileDisplay(width: _width, height: _height)
        : DesktopDisplay(width: _width, height: _height);
  }
}

//create a widget
class MobileDisplay extends StatelessWidget {
  const MobileDisplay({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropDownQuiz(
            blockName: "Maths",
            height: height,
            width: width,
            mode: "teacher",
          ),
          DropDownQuiz(
            blockName: "Physics",
            height: height,
            width: width,
            mode: "teacher",
          ),
          DropDownQuiz(
            blockName: "Chemistry",
            height: height,
            width: width,
            mode: "teacher",
          ),
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
    return Center(
      child: Column(
        children: [
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              DropDownQuiz(
                blockName: "Maths",
                height: height,
                width: width,
                mode: "teacher",
              ),
              DropDownQuiz(
                blockName: "Physics",
                height: height,
                width: width,
                mode: "teacher",
              ),
              DropDownQuiz(
                blockName: "Chemistry",
                height: height,
                width: width,
                mode: "teacher",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
