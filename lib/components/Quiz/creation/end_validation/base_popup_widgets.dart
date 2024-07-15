import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlass, validColor;


const TextStyle _textStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

List<Widget> baseWidgets(
    void Function() onPressed,
    BuildContext context,
    bool isModify
  ) => [

  Text(
    'Are you sure your quiz is ready?',
    style: _textStyle.copyWith(fontSize: 30),
    textAlign: TextAlign.center,
  ),

  const Spacer(),

  MaterialButton(
    onPressed: onPressed,

    color: validColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),

    padding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 10,
    ),

    child: Text(
      '${isModify ? "Modify" : "Create"} quiz',
      style: _textStyle,
    ),
  ),

  const SizedBox(height: 20),

  MaterialButton(
    onPressed: () => Navigator.pop(context),

    color: lightGlass,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),

    child: const Text(
      'Cancel / Back',
      style: _textStyle,
    ),
  ),

  const Spacer(),
];