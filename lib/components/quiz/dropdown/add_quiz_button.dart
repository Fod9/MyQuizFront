import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/colors.dart';

class AddQuizButton extends StatelessWidget {
  const AddQuizButton(this.subject, {super.key});

  final String subject;

  @override
  Widget build(BuildContext context) {

    final Color effectColor = lightGlassBlue.withOpacity(0.4);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 40,
        width: 40,
        child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                  '/create-quiz',
                  arguments: subject,
              );
            },

            splashColor: effectColor,
            focusColor: effectColor,
            hoverColor: effectColor,
            highlightColor: effectColor,
            colorBrightness: Brightness.light,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),

            elevation: 1,

            padding: EdgeInsets.zero,

            color: darkGlass,
            child : const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            )
        ),
      ),
    );
  }
}
