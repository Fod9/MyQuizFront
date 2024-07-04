import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;
import 'package:my_quiz_ap/providers/layout_provider.dart';
import 'package:provider/provider.dart';

class AddQuestionButton extends StatefulWidget {
  const AddQuestionButton(this.onPressed,{super.key});

  final void Function() onPressed;

  @override
  State<AddQuestionButton> createState() => _AddQuestionButtonState();
}

class _AddQuestionButtonState extends State<AddQuestionButton> {

  late final LayoutProvider layoutProvider = Provider.of<LayoutProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        widget.onPressed();
        Future.delayed(const Duration(milliseconds: 100), () {
          layoutProvider.scrollToBottom();
        });
      },

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
