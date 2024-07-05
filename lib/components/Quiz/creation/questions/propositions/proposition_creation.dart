import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/delete_proposition_btn.dart';

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

            const Flexible(
                child: Placeholder()
            ),
          ],
        )
      ),
    );
  }
}
