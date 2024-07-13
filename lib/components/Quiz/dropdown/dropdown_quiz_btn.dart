import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlassBlue;

class DropdownQuizButton extends StatefulWidget {

  const DropdownQuizButton({
    super.key,
    required this.quizName,
    required this.quizId,
    required this.height,
    required this.width,
  });

  final String quizName;
  final int quizId;
  final double height, width;

  @override
  State<DropdownQuizButton> createState() => _DropdownQuizButtonState();
}

class _DropdownQuizButtonState extends State<DropdownQuizButton>
  with SingleTickerProviderStateMixin {

  final Color effectColor = lightGlassBlue.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),

      child: SizedBox(
        height: widget.height,
        width: widget.width,

        child: MaterialButton(

          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/quiz',
              arguments: widget.quizId,
            );
          },

          color: const Color(0x66000000),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          splashColor: effectColor,
          focusColor: effectColor,
          hoverColor: effectColor,
          highlightColor: effectColor,
          colorBrightness: Brightness.light,

          elevation: 0,

          child: Center(
            child: Text(
              widget.quizName,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        ),
      ),
    );
  }
}
