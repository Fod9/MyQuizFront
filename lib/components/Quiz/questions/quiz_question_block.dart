import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_proposition.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_question_button.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';


class QuizQuestionBlock extends StatefulWidget {
  const QuizQuestionBlock({
    super.key,
    required this.question,
  });

  final Map<String, dynamic> question;

  @override
  State<QuizQuestionBlock> createState() => _QuizQuestionBlockState();
}


class _QuizQuestionBlockState extends State<QuizQuestionBlock>
    with AutomaticKeepAliveClientMixin {

  final List<Widget> _propositions = [];
  final List<GlobalKey<QuizPropositionState>> _propositionKeys = [];

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
        )
      );
    }
    setState(() {
      _propositions.addAll(propositions);
    });
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
                    onPressed: validate,
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
