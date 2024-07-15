import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:blurrycontainer/blurrycontainer.dart' show BlurryContainer;
import 'package:my_quiz_ap/components/Quiz/creation/end_validation/base_popup_widgets.dart' show baseWidgets;
import 'package:my_quiz_ap/components/Quiz/creation/end_validation/failed_popup_widgets.dart' show failedWidgets;
import 'package:my_quiz_ap/helpers/Colors.dart' show electricBlue;
import 'package:my_quiz_ap/helpers/colors.dart' show darkGlass;
import 'package:my_quiz_ap/helpers/quiz_creation/create_quiz.dart' show createQuiz;
import 'package:my_quiz_ap/helpers/quiz_creation/modify_quiz.dart';
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;

class _CreateQuizPopup extends StatefulWidget {
  const _CreateQuizPopup(this.quizData);

  final QuizCreationData quizData;

  @override
  State<_CreateQuizPopup> createState() => _CreateQuizPopupState();
}

class _CreateQuizPopupState extends State<_CreateQuizPopup> {

  bool _failed = false;
  bool _loading = false;
  late final bool isModify = widget.quizData.quizId != null;

  void _createModifyQuiz() async {
    setState(() => _loading = true);
    final bool success = isModify ?
      await modifyQuiz(widget.quizData) : await createQuiz(widget.quizData);

    if (success && mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/teacher', (route) => false);
    } else {
      setState(() {_loading = false; _failed = true;});
    }
  }

  late final List<Widget> _baseWidgets = baseWidgets(_createModifyQuiz, context, isModify);

  List<Widget> get _displayedWidgets {
    if (_loading) {
      return [
        const Spacer(flex: 5),
        const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            color: Colors.white,
            strokeCap: StrokeCap.round,
          )
        ),
        const Spacer(flex: 1),
        Text(
          '${isModify ? "Modifying" : "Creating"} quiz...',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 5),
      ];
    } else if (_failed) {
      return failedWidgets(context, isModify);
    } else {
      return _baseWidgets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlurryContainer(
        borderRadius: BorderRadius.circular(20),
        color: darkGlass,
        elevation: 15,
        blur: 30,
        padding: const EdgeInsets.all(20),
        width: (MediaQuery.of(context).size.width * 0.8).clamp(0, 500),
        height: 500,
        shadowColor: electricBlue.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: _loading ?
            CrossAxisAlignment.center : CrossAxisAlignment.stretch,
          children: _displayedWidgets,
        ),
      ),
    );
  }
}


void displayCreateQuizPopup(BuildContext context, QuizCreationData quizData) {
  showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                )
            ),

            _CreateQuizPopup(quizData),
          ],
        );
      }
  );
}
