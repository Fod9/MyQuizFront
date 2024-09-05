import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DropdownQuizButton extends StatefulWidget {

  const DropdownQuizButton({
    super.key,
    required this.quizName,
    required this.quizId,
    required this.height,
    required this.width,
    required this.isTeacher,
  });

  final String quizName;
  final int quizId;
  final double height, width;
  final bool isTeacher;

  @override
  State<DropdownQuizButton> createState() => _DropdownQuizButtonState();
}

class _DropdownQuizButtonState extends State<DropdownQuizButton>
  with SingleTickerProviderStateMixin {

  late final UserProvider _userProvider = Provider.of<UserProvider>(context, listen: false);

  final Color effectColor = lightGlassBlue.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            if (widget.isTeacher) const SizedBox(width: 50),

            Flexible(
              child: SizedBox(
                height: widget.height,
              
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
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      maxLines: 2,
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
            ),

            if (_userProvider.userRole == "teacher") SizedBox(
              width: 50,
              height: widget.height,
              child: IconButton(
                onPressed: () {
                  if (widget.isTeacher) {
                    Navigator.pushNamed(
                      context,
                      '/modify-quiz',
                      arguments: widget.quizId,
                    );
                  }
                },
                icon: const Icon(
                  Icons.edit_note_rounded,
                  color: Colors.white,
                ),
              )
            ) else const SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}
