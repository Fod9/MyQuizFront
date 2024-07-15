import 'package:flutter/material.dart';
import 'dart:ui' show Brightness, Color, FontWeight, ImageFilter;
import 'package:my_quiz_ap/components/Quiz/creation/select_subject_popup.dart'
    show SelectSubjectPopup;
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;
import 'package:my_quiz_ap/helpers/colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show Provider;

class SelectSubjectButton extends StatefulWidget {
  const SelectSubjectButton({
    super.key,
    this.mode = "subject",
    required this.listOfSelections,
  });

  final String mode;
  final List<dynamic> listOfSelections;

  @override
  State<SelectSubjectButton> createState() => _SelectSubjectButtonState();
}

class _SelectSubjectButtonState extends State<SelectSubjectButton> {

  late final QuizCreationData _provider = Provider.of<QuizCreationData>(context, listen: true);

  late final String buttonDefaultText = "Select Subject";

  String getButtonText() {
    return _provider.selectedSubject != null ?
      _provider.selectedSubject!['name']! : buttonDefaultText;
  }

  final Color effectColor = lightGlassBlue.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 200,
        height: 50,
        child: MaterialButton(
          onPressed: () {
            showDialog(context: context,
                barrierColor: Colors.transparent,
                builder: (BuildContext context) {

                  return Stack(
                    children: [

                      BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          )
                      ),

                      SelectSubjectPopup(
                        listOfSelections: widget.listOfSelections,
                        mode: widget.mode,
                        provider: _provider,
                        selectedValue: _provider.selectedSubject,
                      ),
                    ],
                  );

                }
            );
          },

          color: lightGlass,
          elevation: 2.5,

          splashColor: effectColor,
          focusColor: effectColor,
          hoverColor: effectColor,
          highlightColor: effectColor,
          colorBrightness: Brightness.light,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          child: Text(
            getButtonText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}