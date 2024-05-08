import 'package:flutter/material.dart';
import './FormController.dart';


class CustomTextFormField extends StatelessWidget {
  final String type;
  final String label;
  final String hintText;
  final String? errorText;
  final TextEditingController controller;
  final FormController formController;

  const CustomTextFormField({
    Key? key,
    required this.type,
    required this.label,
    required this.hintText,
    required this.errorText,
    required this.controller,
    required this.formController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: type == 'email' ? TextInputType.emailAddress : TextInputType.text,
          onChanged: (value) => formController.handleTextFieldChange(type, value),
          obscureText: type == 'mdp',
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(left: 14.0),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              errorText: errorText,
              errorMaxLines: 4,

          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}