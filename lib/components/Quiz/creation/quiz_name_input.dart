import 'package:flutter/material.dart';
import 'package:my_quiz_ap/providers/quiz_creation_data.dart';
import 'package:provider/provider.dart';

class QuizNameInput extends StatefulWidget {
  const QuizNameInput({super.key});

  @override
  State<QuizNameInput> createState() => _QuizNameInputState();
}

class _QuizNameInputState extends State<QuizNameInput> {

  late final _provider = Provider.of<QuizCreationData>(context, listen: false);
  late final TextEditingController _controller = TextEditingController(text: _provider.quizName);
  late final FocusNode _focusNode = FocusNode();

  void unFocus() => _focusNode.unfocus();


  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [

        const SizedBox(width: 25.0),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IntrinsicWidth(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,

                onChanged: (String value) => _provider.setQuizName(value),

                maxLines: null,

                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),

                decoration: InputDecoration(
                  hintText: 'Quiz Name',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontFamily: 'QuickSand',
                    fontWeight: FontWeight.w600,
                    fontSize: 24.0,
                  ),

                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              if (_focusNode.hasFocus) {
                _focusNode.unfocus();
              } else {
                _focusNode.requestFocus();
              }
            });
          },
          child: SizedBox(
            height: 50.0,
            child: Center(
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                firstCurve: Curves.easeInOut,
                secondCurve: Curves.easeInOut,
                firstChild: const Icon(
                  Icons.edit_rounded,
                  size: 25.0,
                  color: Colors.white,
                ),
                secondChild: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 25.0,
                ),
                crossFadeState: _focusNode.hasFocus ?
                  CrossFadeState.showSecond :
                  CrossFadeState.showFirst,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
