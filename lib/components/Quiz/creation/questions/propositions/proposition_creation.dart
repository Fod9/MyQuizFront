import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/delete_proposition_btn.dart' show DeletePropositionButton;
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/is_correct_switch.dart' show IsCorrectSwitch;
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/proposition_input.dart' show PropositionInput, PropositionInputState;

class PropositionCreation extends StatefulWidget {
  const PropositionCreation({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<PropositionCreation> createState() => PropositionCreationState();
}

class PropositionCreationState extends State<PropositionCreation> {

  final GlobalKey<PropositionCreationState> _propositionKey = GlobalKey<PropositionCreationState>();
  final GlobalKey<PropositionInputState> _propositionInputKey = GlobalKey<PropositionInputState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: _propositionKey,
      padding: const EdgeInsets.only(bottom: 24.0),
      child: SizedBox(
        // height: 50,
        width: MediaQuery.of(context).size.width - 48,
        child: Row(
          children: [
            DeletePropositionButton(index: widget.index, propositionKey: _propositionKey),

            const SizedBox(width: 12.0),

            Flexible(
              flex: 5,
              child: PropositionInput(key: _propositionInputKey, index: widget.index)
            ),

            const SizedBox(width: 12.0),

            Flexible(
              child: IsCorrectSwitch(
                  propositionInputKey: _propositionInputKey,
                  index: widget.index,
              )
            ),
          ],
        )
      ),
    );
  }
}
