import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_proposition.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_question_button.dart';


class QuizQuestionBlock extends StatefulWidget {
  const QuizQuestionBlock({
    super.key,
    required this.question,
    required this.pageController,
  });

  final Map<String, dynamic> question;
  final PageController pageController;

  @override
  State<QuizQuestionBlock> createState() => _QuizQuestionBlockState();
}


class _QuizQuestionBlockState extends State<QuizQuestionBlock>
    with AutomaticKeepAliveClientMixin {

  final List<Widget> _propositions = [];
  final List<GlobalKey<QuizPropositionState>> _propositionKeys = [];
  final GlobalKey<QuizQuestionButtonState> _buttonKey = GlobalKey();

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

  void validate() {
    for (final key in _propositionKeys) {
      key.currentState!.check();
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DecoratedBox(
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

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: _propositions,
                    ),
                  ),
                ),

                const Spacer(),

                Align(
                  alignment: Alignment.centerRight,
                  child: QuizQuestionButton(
                    key: _buttonKey,
                    onPressed: validate,
                    pageController: widget.pageController,
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
