import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_question_block.dart' show QuizQuestionBlock;


/// The body of the quiz page.
/// This widget displays the questions of the quiz.
///
/// params: [Map<String, dynamic>] [quiz]
class QuizBody extends StatefulWidget {
  const QuizBody({
    super.key,
    required this.quiz,
    required this.addScore,
    required this.getScore,
  });

  final Map<String, dynamic> quiz;
  final Function(int) addScore;
  final List<int> Function() getScore;

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController(
      initialPage: 0,
      keepPage: true,
  );

  int _currentPage = 1;


  /// Get the list of questions and propositions of the quiz.
  /// Displayed in a page view.
  List<Widget> get _getQuestions {
    final List<Widget> questions = [];
    final int lastIndex = widget.quiz['Questions'].length - 1;
    for (int i = 0; i <= lastIndex; i++) {
      final question = widget.quiz['Questions'][i];
      questions.add(
          QuizQuestionBlock(
            question: question,
            pageController: _pageController,
            addScore: widget.addScore,
            isLast: i == lastIndex,
            getScore: i == lastIndex ? widget.getScore : null,
          )
      );
    }
    return questions;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<Widget> questions = _getQuestions;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.825,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            // current question number
            Text(
              "Question $_currentPage/${questions.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
              ),
            ),

            // PageView to display the questions
            // No scroll physics, scrolls only with "next" button
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int page) {
                  // update the current page number when the page changes
                  setState(() => _currentPage = page + 1);
                },
                children: questions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // keep the state of the widget
  // even when the widget is not visible
  @override
  bool get wantKeepAlive => true;
}
