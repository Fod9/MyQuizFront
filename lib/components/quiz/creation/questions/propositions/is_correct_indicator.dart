import 'package:flutter/material.dart';
import 'package:my_quiz_ap/providers/question_creation_data.dart' show Proposition, QuestionCreationData;
import 'package:provider/provider.dart' show Provider;

class IsCorrectIndicator extends StatefulWidget {

  const IsCorrectIndicator({
    super.key,
    required this.index,
    required this.color,
  });

  final int index;
  final Color color;

  @override
  State<IsCorrectIndicator> createState() => _IsCorrectIndicatorState();
}

class _IsCorrectIndicatorState extends State<IsCorrectIndicator> {

  late final QuestionCreationData _provider = Provider.of<QuestionCreationData>(context);
  late final Proposition _proposition = _provider.propositions.elementAt(widget.index);

  Widget correctText(String text) => Text(
      text,
      textAlign: TextAlign.end,
      overflow: TextOverflow.fade,
      softWrap: false,
      maxLines: 1,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600
      ),
  );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12)
          )
      ),

      child: SizedBox(
        height: 25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                firstChild: correctText('Correct'),
                secondChild: correctText('Incorrect'),
                crossFadeState: _proposition.isCorrect ?
                  CrossFadeState.showFirst : CrossFadeState.showSecond,
            ),
          ),
        ),
      ),
    );
  }
}
