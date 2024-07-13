import 'package:flutter/material.dart';
import 'dart:ui' show Brightness, Color, FontWeight, ImageFilter;
import 'package:my_quiz_ap/components/Quiz/creation/select_subject_class_popup.dart' show SelectSubjectClassPopup;
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;
import 'package:my_quiz_ap/helpers/colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show Provider;

class SelectSubjectClassButton extends StatefulWidget {
  const SelectSubjectClassButton({
    super.key,
    required this.mode,
    required this.listOfSelections,
  });

  final String mode;
  final List<dynamic> listOfSelections;

  @override
  State<SelectSubjectClassButton> createState() => _SelectSubjectClassButtonState();
}

class _SelectSubjectClassButtonState extends State<SelectSubjectClassButton> {

  late final QuizCreationData _provider = Provider.of<QuizCreationData>(context, listen: true);

  late final bool isModeValid = ["subject", "class"].contains(widget.mode);

  late final String buttonDefaultText = isModeValid ?
  widget.mode == "subject" ? "Select subject" : "Select class"
      :
  "Invalid mode";

  String getButtonText() {
    if (widget.mode == "subject") {
      return _provider.selectedSubject != null ? _provider.selectedSubject!['name']!
          : buttonDefaultText;
    } else {
      return _provider.selectedClass != null ? _provider.selectedClass!['name']!
          : buttonDefaultText;
    }
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
          onPressed: !isModeValid ? null : () {
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

                      SelectSubjectClassPopup(
                        listOfSelections: widget.listOfSelections,
                        mode: widget.mode,
                        provider: _provider,
                        selectedValue: widget.mode == "subject" ?
                        _provider.selectedSubject : _provider.selectedClass,
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