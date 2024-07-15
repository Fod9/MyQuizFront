import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart' show BlurryContainer;
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass;
import 'package:my_quiz_ap/helpers/colors.dart' show electricBlue, darkGlass, validColor;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;

class SelectClassesPopup extends StatefulWidget {
  const SelectClassesPopup({
    super.key,
    required this.listOfSelections,
    required this.provider,
  });

  final List<dynamic> listOfSelections;
  final QuizCreationData provider;

  @override
  State<SelectClassesPopup> createState() => _SelectClassesPopupState();
}

class _SelectClassesPopupState extends State<SelectClassesPopup> {

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
              if (_provider.selectedClasses.contains(selection)) {
                _provider.removeClass(selection);
              } else {
                _provider.addClass(selection);
              }
              setState(() {});
            },
            color: _provider.selectedClasses.contains(selection) ?
              validColor : darkGlass,
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
        color: lightGlass,
        elevation: 15,
        blur: 30,
        padding: const EdgeInsets.all(20),
        width: (MediaQuery.of(context).size.width * 0.8).clamp(0, 500),
        height: 500,
        shadowColor: electricBlue.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Select Classes",
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