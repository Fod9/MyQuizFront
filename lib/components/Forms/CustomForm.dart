import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Forms/FormController.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';
import 'package:my_quiz_ap/components/Forms/TextFormField.dart';

enum FormMode {
  login,
  register,
}

class CustomForm extends StatelessWidget {
  const CustomForm({
    Key? key,
    required this.height,
    required this.width,
    required this.formController,
    required this.mode,
  }) : super(key: key);

  final double height;
  final double width;
  final FormController formController;
  final FormMode mode;

  @override
  Widget build(BuildContext context) {
    final formFields = mode == FormMode.register
        ? [
      {"type": "nom", "label": "Nom :", "hintText": "Entrez votre nom"},
      {"type": "prenom", "label": "Prénom :", "hintText": "Entrez votre prénom"},
      {"type": "email", "label": "Email :", "hintText": "Entrez votre email"},
      {"type": "pseudo", "label": "Nom d'utilisateur :", "hintText": "Choisissez un nom d'utilisateur"},
      {"type": "mdp", "label": "Mot de passe :", "hintText": "Choisissez un mot de passe"},
    ]
        : [
      {"type": "email", "label": "Email :", "hintText": "Entrez votre email"},
      {"type": "mdp", "label": "Mot de passe :", "hintText": "Entrez votre mot de passe"},
    ];

    return Form(
      key: mode == FormMode.register ? formController.formKeyInscription : formController.formKeyConnexion,
      child: Container(
        height: height * (mode == FormMode.register ? 7.7 : 3.4),
        width: width * 1.1,
        decoration: BoxDecoration(
          color: darkGlass,
          borderRadius: BorderRadius.circular(height * (mode == FormMode.register ? 7.3 : 4) * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: formFields.map((field) {
              return CustomTextFormField(
                type: field['type'] as String,
                label: field['label'] as String,
                hintText: field['hintText'] as String,
                errorText: formController.getErrorText(field['type']!),
                controller: formController.getController(field['type']!),
                formController: formController,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}