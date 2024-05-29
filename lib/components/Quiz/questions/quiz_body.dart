import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_question_block.dart' show QuizQuestionBlock;

class QuizBody extends StatefulWidget {
  const QuizBody({
    super.key,
    required this.quiz,
  });

  final Map<String, dynamic> quiz;

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

  List<Widget> get _getQuestions {
    final List<Widget> questions = [];
    for (final question in widget.quiz['Questions']) {
      questions.add(
          QuizQuestionBlock(
            question: question,
            pageController: _pageController,
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
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page + 1;
                  });
                },
                children: questions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
