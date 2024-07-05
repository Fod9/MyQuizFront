import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/delete_proposition_btn.dart' show DeletePropositionButton;
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/proposition_input.dart';
import 'package:my_quiz_ap/providers/question_creation_data.dart' show Proposition, QuestionCreationData;
import 'package:provider/provider.dart' show Provider;

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
  late final QuestionCreationData _provider = Provider.of<QuestionCreationData>(context);
  late final List<Proposition> _propositions = _provider.propositions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: _propositionKey,
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width - 48,
        child: Row(
          children: [
            DeletePropositionButton(index: widget.index, propositionKey: _propositionKey),

            const SizedBox(width: 12.0),


            PropositionInput(index: widget.index),
          ],
        )
      ),
    );
  }
}
