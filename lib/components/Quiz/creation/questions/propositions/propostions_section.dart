import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/add_proposition_btn.dart' show AddPropositionButton;
import 'package:my_quiz_ap/components/Quiz/creation/questions/propositions/proposition_creation.dart' show PropositionCreation;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show Proposition, QuestionCreationData;
import 'package:provider/provider.dart' show Provider;

class PropositionsSection extends StatefulWidget {
  const PropositionsSection({super.key});

  @override
  State<PropositionsSection> createState() => _PropositionsSectionState();
}

class _PropositionsSectionState extends State<PropositionsSection> {

  late final _provider = Provider.of<QuestionCreationData>(context);
  late final List<Proposition> _propositions = _provider.propositions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _propositions.length; i++)
          PropositionCreation(index: i),

        const AddPropositionButton(),
      ],
    );
  }
}
