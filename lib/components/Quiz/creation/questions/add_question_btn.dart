import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;

class AddQuestionButton extends StatefulWidget {
  const AddQuestionButton(this.onPressed,{super.key});

  final void Function() onPressed;

  @override
  State<AddQuestionButton> createState() => _AddQuestionButtonState();
}

class _AddQuestionButtonState extends State<AddQuestionButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,

      color: lightGlass,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      child: const Text(
        'Add question',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
