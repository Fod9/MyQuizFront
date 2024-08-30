import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/forms/custom_form_controller.dart' show FormController;


class CustomTextFormField extends StatelessWidget {
  final String type;
  final String label;
  final String hintText;
  final String? errorText;
  final TextEditingController controller;
  final FormController formController;
  final String fontFamily;

  const CustomTextFormField({
    super.key,
    required this.type,
    required this.label,
    required this.hintText,
    required this.errorText,
    required this.controller,
    required this.formController,
    this.fontFamily = 'QuickSand',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: fontFamily,
          ),
        ),

        const SizedBox(height: 5),

        TextFormField(
          controller: controller,
          keyboardType: type == 'email' ? TextInputType.emailAddress : TextInputType.text,
          onChanged: (value) => formController.handleTextFieldChange(type, value),
          obscureText: type == 'mdp',

          autofillHints:
            type == 'email' ? [AutofillHints.email] :
            type == 'mdp' ? [AutofillHints.password] :
            null,

          style: TextStyle(
            fontSize: 14,
            fontFamily: fontFamily,
          ),

          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(left: 14.0),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),

              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: fontFamily,
              ),

              errorText: errorText,
              errorMaxLines: 4,
              errorStyle: TextStyle(
                color: Colors.red,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
          ),
        ),
      ],
    );
  }
}