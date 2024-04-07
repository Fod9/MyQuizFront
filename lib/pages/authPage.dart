import 'package:flutter/material.dart';
import '../helpers/Colors.dart';
import '../helpers/validators.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.screenType});

  final String screenType;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class FormController {
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

  void handleTextFieldChange(String type, String value) {
    switch (type) {
      case "nom":
        nameError = Validator.validateName(value);
        break;
      case "prenom":
        nameError = Validator.validateName(value);
        break;
      case "email":
        emailError = Validator.validateEmail(value);
        break;
      case "pseudo":
        usernameError = Validator.validateUsername(value);
        break;
      case "mdp":
        pwdError = Validator.validatePassword(value);
        if (confirmPwdController.text.isNotEmpty) {
          confirmPwdError = Validator.comparePasswords(confirmPwdController.text, value);
        }
        break;
      case "confirmMdp":
        confirmPwdError = Validator.comparePasswords(value, pwdController.text);
        break;
    }
  }
}

class _AuthPageState extends State<AuthPage> {
  double _width = 300;
  double _height = 150;
  String authType = "inscription";
  bool isLoginFormDisplayed = false;

  final FormController formController = FormController();


  final formKeyInscription = GlobalKey<FormState>();
  final formKeyConnexion = GlobalKey<FormState>();


  void handleFormSubmit(String formType) {
    if (formType == "inscription") {
      if (formKeyInscription.currentState!.validate()) {
        // Form submission logic for inscription form
      }
    } else {
      if (formKeyConnexion.currentState!.validate()) {
        // Form submission logic for connexion form
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == "mobile") {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return (widget.screenType == "mobile" || _width > 600)
        ? MobileDisplay(
      width: _width,
      height: _height,
      toggleForm: toggleForm,
      isLoginFormDisplayed: isLoginFormDisplayed,
      formController: formController,
    )
        : DesktopDisplay(width: _width, height: _height);
  }
  void toggleForm() {
    setState(() {
      isLoginFormDisplayed = !isLoginFormDisplayed;
    });
  }
}

//create a widget
class MobileDisplay extends StatelessWidget {
  const MobileDisplay({
    Key? key,
    required this.width,
    required this.height,
    required this.toggleForm,
    required this.isLoginFormDisplayed,
    required this.formController,
  }) : super(key: key);

  final double width;
  final double height;
  final void Function() toggleForm;
  final bool isLoginFormDisplayed;
  final FormController formController;

  Widget _buildTextFormField(String type, String label, String hintText, String? errorText, TextEditingController controller) {
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
          onChanged: (value) => {formController.handleTextFieldChange(type, value)},
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
            errorMaxLines: 4
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildInscriptionForm() {
    return Form(
      key: formController.formKeyInscription,
      child: Container(
        height: height * 7.7,
        width: width * 1.1,
        decoration: BoxDecoration(
          color: darkGlass,
          borderRadius: BorderRadius.circular(height * 7.3 * 0.03),
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
            children: [
              _buildTextFormField("nom", "Nom :", "Entrez votre nom", formController.nameError, formController.nameController),
              _buildTextFormField("prenom", "Prénom :", "Entrez votre prénom", formController.nameError, formController.firstnameController),
              _buildTextFormField("email", "E-mail :", "Entrez votre e-mail", formController.emailError, formController.emailController),
              _buildTextFormField("pseudo", "Nom d'utilisateur :", "Choisissez votre nom d'utilisateur", formController.usernameError, formController.usernameController),
              _buildTextFormField("mdp", "Mot de passe :", "Choisissez un mot de passe", formController.pwdError, formController.pwdController),
              TextFormField(
                controller: formController.confirmPwdController,
                onChanged: (value) {
                  formController.handleTextFieldChange("confirmMdp", value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 14.0),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Confirmez votre mot de passe",
                  hintStyle: const TextStyle(color: Colors.grey),
                  errorText: formController.confirmPwdError,
                  errorMaxLines: 4
                ),
                style: const TextStyle(fontSize: 14)
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: width * 0.4,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    color: electricBlue,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: electricBlue.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        if (formController.formKeyInscription.currentState!.validate()) {
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text("Je m'inscris")
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnexionForm() {
    return Form(
      key: formController.formKeyConnexion,
      child: Container(
        height: height * 3.4,
        width: width * 1.1,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: darkGlass,
          borderRadius: BorderRadius.circular(height * 4 * 0.055),
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
            children: [
              _buildTextFormField("pseudo", "Nom d'utilisateur :", "Entrez votre nom d'utilisateur", formController.usernameError, formController.usernameController),
              _buildTextFormField("mdp", "Mot de passe :", "Entrez votre mot de passe", formController.pwdError, formController.pwdController),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: width * 0.5,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    color: electricBlue,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: electricBlue.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        if (formController.formKeyConnexion.currentState!.validate()) {
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text("Je me connecte")
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            isLoginFormDisplayed ? _buildConnexionForm() : _buildInscriptionForm(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: width * 0.6,
                height: height * 0.6,
                decoration: BoxDecoration(
                  color: darkGlass,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: toggleForm,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  child: Text(isLoginFormDisplayed ? "Je n'ai pas de compte" : "J'ai déjà un compte"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DesktopDisplay extends StatelessWidget {
  DesktopDisplay({super.key, required this.width, required this.height});

  final double width;
  final double height;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return const Center(
    );
  }
}
