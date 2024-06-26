import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/select_subject_class_popup.dart' show SelectSubjectClassPopup;
import 'package:my_quiz_ap/helpers/colors.dart';
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

  late final QuizCreationData _provider = Provider.of<QuizCreationData>(context);

  late final bool isModeValid = ["subject", "class"].contains(widget.mode);

  late final String buttonDefaultText = isModeValid ?
  widget.mode == "subject" ? "Select subject" : "Select class"
      :
  "Invalid mode";

  String getButtonText() {
    if (widget.mode == "subject") {
      return _provider.selectedSubject != null ? _provider.selectedSubject! : buttonDefaultText;
    } else {
      return _provider.selectedClass != null ? _provider.selectedClass! : buttonDefaultText;
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
                builder: (BuildContext context) {
                  return SelectSubjectClassPopup(
                    listOfSelections: widget.listOfSelections,
                    title: buttonDefaultText,
                    selectedValue: widget.mode == "subject" ?
                    _provider.selectedSubject : _provider.selectedClass,
                  );
                }
            );
          },

          color: darkGlass,
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