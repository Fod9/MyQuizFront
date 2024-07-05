import 'package:flutter/material.dart';
import 'package:my_quiz_ap/providers/question_creation_data.dart';
import 'package:provider/provider.dart';

class PropositionInput extends StatefulWidget {
  const PropositionInput({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<PropositionInput> createState() => _PropositionInputState();
}

class _PropositionInputState extends State<PropositionInput> {

  late final QuestionCreationData _provider = Provider.of<QuestionCreationData>(context);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: SizedBox(
          height: 50,
          child: TextField(
            controller: _provider.propositions.elementAt(widget.index).controller,
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
        )
    );
  }
}
