import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/quiz/creation/subject_and_classes/select_classes_popup.dart';
import 'dart:ui' show Brightness, Color, FontWeight, ImageFilter;
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;
import 'package:my_quiz_ap/helpers/colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show Provider;

class SelectClassesButton extends StatefulWidget {
  const SelectClassesButton({
    super.key,
    required this.listOfSelections,
  });

  final List<dynamic> listOfSelections;

  @override
  State<SelectClassesButton> createState() => _SelectClassesButtonState();
}

class _SelectClassesButtonState extends State<SelectClassesButton> {

  late final QuizCreationData _provider = Provider.of<QuizCreationData>(context, listen: true);
  late final List<Map<String,dynamic>> _selectedClasses = _provider.selectedClasses;

  late final String buttonDefaultText = "Select Classes";

  String get buttonText {
    if (_selectedClasses.length == 1) {
      return _selectedClasses[0]['name'];
    } else if (_selectedClasses.isNotEmpty) {
      return _provider.selectedClasses.map((class_) => class_['name']).join(", ");
    } else {
      return buttonDefaultText;
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
          onPressed: () {
            showDialog(
                context: context,
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

                      SelectClassesPopup(
                          listOfSelections: widget.listOfSelections,
                          provider: _provider,
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
            buttonText,
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