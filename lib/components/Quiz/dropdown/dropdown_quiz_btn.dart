import 'package:flutter/material.dart';

class DropdownQuizButton extends StatefulWidget {

  const DropdownQuizButton({
    super.key,
    required this.quizName,
    required this.height,
    required this.width,
  });

  final String quizName;
  final double height, width;

  @override
  State<DropdownQuizButton> createState() => _DropdownQuizButtonState();
}

class _DropdownQuizButtonState extends State<DropdownQuizButton>
  with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: 200,
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          widget.quizName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        color: Colors.blue,
      ),
    );
  }
}
