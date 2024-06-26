import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart' show BlurryContainer;
import 'package:my_quiz_ap/helpers/colors.dart' show darkGlass, electricBlue, lightGlassBlue;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;

class SelectSubjectClassPopup extends StatefulWidget {
  const SelectSubjectClassPopup({
    super.key,
    required this.listOfSelections,
    required this.mode,
    required this.provider,
    this.selectedValue,
  });

  final List<dynamic> listOfSelections;
  final String mode;
  final Map<String, dynamic>? selectedValue;
  final QuizCreationData provider;

  @override
  State<SelectSubjectClassPopup> createState() => _SelectSubjectClassPopupState();
}

class _SelectSubjectClassPopupState extends State<SelectSubjectClassPopup> {

  late final QuizCreationData _provider = widget.provider;

  final TextStyle _textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: "Quicksand",
    fontWeight: FontWeight.w600,
  );

  Iterable<Widget> _getSelectionList() sync* {
    for (dynamic selection in widget.listOfSelections) {

      String selectionName = selection["name"]!;

      yield Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200,
            minHeight: 50,
          ),
          child: MaterialButton(
            onPressed: () {
              if (widget.mode == "subject") {
                _provider.setSelectedSubject(selection);
              } else {
                _provider.setSelectedClass(selection);
              }
              Navigator.of(context).pop();
            },
            color: selectionName == widget.selectedValue?['name'] ? lightGlassBlue : electricBlue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              selectionName,
              style: _textStyle,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlurryContainer(
        borderRadius: BorderRadius.circular(20),
        color: darkGlass,
        elevation: 15,
        blur: 30,
        padding: const EdgeInsets.all(20),
        width: (MediaQuery.of(context).size.width * 0.8).clamp(0, 500),
        height: 500,
        shadowColor: electricBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.mode == "subject" ? "Select a subject" : "Select a class",
              style: _textStyle.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ..._getSelectionList(),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

