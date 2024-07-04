import 'package:flutter/material.dart';

class PropositionCreation extends StatefulWidget {
  const PropositionCreation({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<PropositionCreation> createState() => _PropositionCreationState();
}

class _PropositionCreationState extends State<PropositionCreation> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        height: 50,
        child: Placeholder()
      ),
    );
  }
}
