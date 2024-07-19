import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:my_quiz_ap/components/quiz/questions/quiz_proposition.dart' show QuizProposition, QuizPropositionState;
import 'package:my_quiz_ap/components/quiz/questions/quiz_question_button.dart' show QuizQuestionButton, QuizQuestionButtonState;
import 'package:my_quiz_ap/helpers/utils.dart' show printInfo;
import 'package:my_quiz_ap/providers/quiz_data.dart' show QuizData;
import 'package:provider/provider.dart' show Provider;

/// A widget that displays a question, its propositions
/// and a button to validate the answer.
///
/// params:
/// - [Map<String, dynamic>] [question]
/// - [PageController] [pageController]
class QuizQuestionBlock extends StatefulWidget {
  const QuizQuestionBlock({
    super.key,
    required this.question,
    required this.pageController,
    this.isLast = false,
  });

  final Map<String, dynamic> question;  // the question contains its propositions
  final PageController pageController;
  final bool isLast;

  @override
  State<QuizQuestionBlock> createState() => _QuizQuestionBlockState();
}


class _QuizQuestionBlockState extends State<QuizQuestionBlock>
    with AutomaticKeepAliveClientMixin {

  final List<Widget> _propositions = [];
  final List<GlobalKey<QuizPropositionState>> _propositionKeys = [];
  final GlobalKey<QuizQuestionButtonState> _buttonKey = GlobalKey();

  /// Get and generate the propositions of the question.
  void _getPropositions() {
    final List<Widget> propositions = [];
    int currentIndex = 1;
    for (final proposition in widget.question['Propositions']) {

      final GlobalKey<QuizPropositionState> key = GlobalKey();
      _propositionKeys.add(key);

      propositions.add(
        QuizProposition(
          key: key,
          proposition: proposition,
          index: currentIndex++,
          onPressed: _checkAtLeastOne,
        )
      );
    }
    setState(() {
      _propositions.addAll(propositions);
    });
  }

  /// Check if at least one proposition is selected.
  /// If so, enable the validate button.
  ///
  /// Takes all the propositions keys and check if at least one is selected.
  void _checkAtLeastOne() {
    bool atLeastOne = false;
    for (final key in _propositionKeys) {
      if (key.currentState!.isSelected) {
        atLeastOne = true;
        break;
      }
    }
    if (atLeastOne) {
      _buttonKey.currentState!.enable();
    } else {
      _buttonKey.currentState!.disable();
    }
  }

  /// Validate the propositions.
  ///
  /// Takes all the propositions keys and check if the selected propositions
  /// are the correct ones by comparing them to the correct answers.
  void validate() {

    // list of the selected propositions
    final List<bool> results = <bool>[];
    for (final key in _propositionKeys) {
      final bool result = key.currentState!.check();
      results.add(result);
    }

    // list of the correct answers
    final List<bool> corrects = <bool>[];
    for (final proposition in widget.question['Propositions']) {
      corrects.add(proposition['Is_correct']);
    }

    // check if the 2 lists are equal
    final bool questionResult = listEquals(results, corrects);

    printInfo("results: $results");
    printInfo("corrects: $corrects");

    if (questionResult) {
      Provider.of<QuizData>(context, listen: false).addScore(1);
    }
  }

  @override
  void initState() {
    super.initState();
    _getPropositions();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DecoratedBox(  // Question text
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0
                      ),
                      child: Text(
                        widget.question['Question_text'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  flex: 15,  // will take 15/17 of the available space
                  child: SingleChildScrollView(
                    child: Column(
                      children: _propositions,
                    ),
                  ),
                ),

                const Spacer(flex: 1),  // will take 1/17 of the available space

                Align(  // Validate button
                  alignment: Alignment.centerRight,
                  child: QuizQuestionButton(
                    key: _buttonKey,
                    onPressed: validate,
                    pageController: widget.pageController,
                    isLast: widget.isLast,
                  )
                )
              ],
            ),
          ),
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
