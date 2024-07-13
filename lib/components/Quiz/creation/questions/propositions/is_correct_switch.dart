import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/proposition_input.dart' show PropositionInputState;
import 'package:my_quiz_ap/helpers/Colors.dart' show invalidColor, validColor;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show Proposition, QuestionCreationData;
import 'package:provider/provider.dart' show Provider;

class IsCorrectSwitch extends StatefulWidget {
  const IsCorrectSwitch({
    super.key,
    required this.propositionInputKey,
    required this.index,
  });

  final GlobalKey<PropositionInputState> propositionInputKey;
  final int index;

  @override
  State<IsCorrectSwitch> createState() => _IsCorrectSwitchState();
}

class _IsCorrectSwitchState extends State<IsCorrectSwitch> {

  late final QuestionCreationData _provider = Provider.of<QuestionCreationData>(context);
  late final Proposition _proposition = _provider.propositions[widget.index];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Switch(
        value: _proposition.isCorrect,
        activeTrackColor: validColor,
        inactiveTrackColor: invalidColor,
        inactiveThumbColor: Colors.white,
        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        onChanged: (bool value) {
          setState(() {
            widget.propositionInputKey.currentState!.updateColor(value);
            _proposition.isCorrect = value;
          });
        },
      ),
    );
  }
}
