import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/dropDownQuiz.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key, required this.screenType});

  final String screenType;

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  double _width = 300;
  double _height = 150;

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == "mobile") {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return (widget.screenType == "mobile")
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
            matiereName: "Maths",
            height: height,
            width: width,
          ),
          DropDownQuiz(
            matiereName: "Physics",
            height: height,
            width: width,
          ),
          DropDownQuiz(
            matiereName: "Chemistry",
            height: height,
            width: width,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDownQuiz(
          matiereName: "Maths",
          height: height,
          width: width,
        ),
        DropDownQuiz(
          matiereName: "Physics",
          height: height,
          width: width,
        ),
        DropDownQuiz(
          matiereName: "Chemistry",
          height: height,
          width: width,
        ),
      ],
    );
  }
}
