import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/quiz/creation/questions/propositions/is_correct_indicator.dart' show IsCorrectIndicator;
import 'package:my_quiz_ap/helpers/Colors.dart' show invalidColor, validColor;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show Proposition, QuestionCreationData;
import 'package:provider/provider.dart' show Provider;

class PropositionInput extends StatefulWidget {
  const PropositionInput({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<PropositionInput> createState() => PropositionInputState();
}

class PropositionInputState extends State<PropositionInput>
    with SingleTickerProviderStateMixin {

  late final QuestionCreationData _provider = Provider.of<QuestionCreationData>(context);
  late final Proposition _proposition = _provider.propositions.elementAt(widget.index);
  late final TextEditingController _textController = _proposition.controller;

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
    value: _proposition.isCorrect ? 0 : 1,
  )..addListener(() {
    setState(() {});
  });

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  );

  Color get _color => Color.lerp(
      validColor,
      invalidColor,
      _animation.value
  ) ?? Colors.white;

  void updateColor(bool isCorrect) {
    if (isCorrect) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Positioned(
            bottom: -18,
            right: 0,
            child: IsCorrectIndicator(
                index: widget.index,
                color: _color,
            ),
        ),

        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: _color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),

            child: TextField(
              controller: _textController,
              focusNode: _proposition.focusNode,
              onTapOutside: (_) => _proposition.focusNode.unfocus(),
              onChanged: (String value) {
                _provider.propositions.elementAt(widget.index).text = value;
              },
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Proposition',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
