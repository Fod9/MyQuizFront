import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:my_quiz_ap/providers/question_creation_data.dart' show QuestionCreationData;

class QuestionNameInput extends StatefulWidget {
  const QuestionNameInput({super.key});

  @override
  State<QuestionNameInput> createState() => _QuestionNameInputState();
}

class _QuestionNameInputState extends State<QuestionNameInput> {

  late final _provider = Provider.of<QuestionCreationData>(context, listen: false);
  late final TextEditingController _controller = TextEditingController(text: _provider.name);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: _controller,
        focusNode: _provider.nameFocusNode,
        onTapOutside: (_) => _provider.nameFocusNode.unfocus(),
        onChanged: (value) => _provider.name = value,
        maxLines: null,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: 'Question',
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
