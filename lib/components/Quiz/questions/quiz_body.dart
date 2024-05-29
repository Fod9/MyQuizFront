import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_question_block.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({
    super.key,
    required this.quiz,
  });

  final Map<String, dynamic> quiz;

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(
      initialPage: 0,
      keepPage: true,
  );

  int _currentPage = 1;

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> get _getQuestions {
    final List<Widget> questions = [];
    for (final question in widget.quiz['Questions']) {
      questions.add(QuizQuestionBlock(question: question));
    }
    return questions;
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> questions = _getQuestions;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Question $_currentPage/${questions.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                children: questions,
                // TODO physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page + 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
