import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/quiz/creation/questions/propositions/proposition_creation.dart' show PropositionCreationState;
import 'package:my_quiz_ap/helpers/Colors.dart' show invalidColor;
import 'package:my_quiz_ap/providers/layout_provider.dart' show LayoutProvider;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show QuestionCreationData;
import 'package:provider/provider.dart' show Provider;

class DeletePropositionButton extends StatefulWidget {
  const DeletePropositionButton({
    super.key,
    required this.index,
    required this.propositionKey,
  });

  final int index;
  final GlobalKey<PropositionCreationState> propositionKey;

  @override
  State<DeletePropositionButton> createState() => _DeletePropositionButtonState();
}

class _DeletePropositionButtonState extends State<DeletePropositionButton> {

  late final QuestionCreationData _provider = Provider.of<QuestionCreationData>(context, listen: false);
  late final _layoutProvider = Provider.of<LayoutProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: MaterialButton(
          onPressed: () {

            final RenderBox renderBox = widget.propositionKey.currentContext!.findRenderObject() as RenderBox;
            final Size size = renderBox.size;
            final double height = size.height;

            _layoutProvider.scrollUp(height);

            Future.delayed(const Duration(milliseconds: 125), () {
              _provider.removeProposition(widget.index);
            });
          },

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          padding: EdgeInsets.zero,

          child: const Icon(
            Icons.delete_rounded,
            color: invalidColor,
          ),
      ),
    );
  }
}
