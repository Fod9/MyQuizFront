import 'package:flutter/cupertino.dart';

import '../../helpers/validators.dart';

class FormController with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  String? nameError;
  String? emailError;
  String? usernameError;
  String? pwdError;
  String? confirmPwdError;

  final formKeyInscription = GlobalKey<FormState>();
  final formKeyConnexion = GlobalKey<FormState>();

  String? getErrorText(String type) {
    switch (type) {
      case "nom":
        return nameError;
      case "prenom":
        return nameError;
      case "email":
        return emailError;
      case "pseudo":
        return usernameError;
      case "mdp":
        return pwdError;
      default:
        return null;
    }
  }

  TextEditingController getController(String type) {
    switch (type) {
      case "nom":
        return nameController;
      case "prenom":
        return firstnameController;
      case "email":
        return emailController;
      case "pseudo":
        return usernameController;
      case "mdp":
        return pwdController;
      default:
        return TextEditingController();
    }
  }

  void handleTextFieldChange(String type, String value) {
    switch (type) {
      case "nom":
        nameError = Validator.validateName(value);
        notifyListeners();
        break;
      case "prenom":
        nameError = Validator.validateName(value);
        notifyListeners();
        break;
      case "email":
        emailError = Validator.validateEmail(value);
        notifyListeners();
        break;
      case "pseudo":
        usernameError = Validator.validateUsername(value);
        notifyListeners();
        break;
      case "mdp":
        pwdError = Validator.validatePassword(value);
        notifyListeners();
        break;
      default:
        break;
    }
  }
}
