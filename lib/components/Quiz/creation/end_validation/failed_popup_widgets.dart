import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/end_validation/base_popup_widgets.dart' show baseWidgets;

List<Widget> failedWidgets (BuildContext context) => [
  const Text(
    'Failed to create quiz',
    style: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),

  const SizedBox(height: 20),

  const Text(
    'Check if all fields are filled and try again',
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),

  const Spacer(),

  baseWidgets(() => Navigator.pop(context), context)[4],

  const Spacer(),
];