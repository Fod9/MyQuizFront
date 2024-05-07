import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown_quiz_body.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown_quiz_header.dart';

class DropDownQuiz extends StatefulWidget {
  const DropDownQuiz({
    super.key,
    required this.blockName,
    required this.height,
    required this.width,
    required this.quizList,
    this.mode = "student",
  });

  final String blockName;
  final double height;
  final double width;
  final String mode;
  final List<Map<String, dynamic>> quizList;

  @override
  State<DropDownQuiz> createState() => _DropDownQuizState();
}

class _DropDownQuizState extends State<DropDownQuiz> {

  final GlobalKey<DropdownQuizHeaderState> _headerKey = GlobalKey();
  final GlobalKey<DropdownQuizBodyState> _bodyKey = GlobalKey();

  void toggleExpand() {
    if (widget.mode == "teacher") {
      _headerKey.currentState!.toggleExpand();
      _bodyKey.currentState!.toggleExpand();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownQuizHeader(
              key: _headerKey,
              blockName: widget.blockName,
              height: 50,
              width: widget.width,
              expandedHeight: 140,
              toggleExpand: toggleExpand,
            ),

            DropdownQuizBody(
              key: _bodyKey,
              width: widget.width,
              height: widget.height,
              quizList: widget.quizList,
            ),
          ],
        ),
      ),
    );
  }
}

