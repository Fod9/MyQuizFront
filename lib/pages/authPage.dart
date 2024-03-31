import 'package:flutter/material.dart';
import '../helpers/Colors.dart';
import 'package:my_quiz_ap/components/sizedBlock.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.screenType});

  final String screenType;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  double _width = 300;
  double _height = 150;
  String authType = "inscription";
  bool isLoginFormDisplayed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == "mobile") {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return (widget.screenType == "mobile" || _width > 600)
        ? MobileDisplay(width: _width, height: _height, toggleForm: toggleForm, isLoginFormDisplayed: isLoginFormDisplayed)
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
  MobileDisplay({Key? key, required this.width, required this.height, required this.toggleForm, required this.isLoginFormDisplayed}) : super(key: key);

  final double width;
  final double height;
  final void Function() toggleForm;
  final formKey = GlobalKey<FormState>();
  final bool isLoginFormDisplayed;

  Widget _buildTextFormField(String label, String hintText) {
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
          controller: TextEditingController(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 14.0),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(fontSize: 14),
          validator: (value) {},
        ),
      ],
    );
  }

  String? validateEmail(String value) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value.isNotEmpty) {
      if (!regex.hasMatch(value)) {
        return 'Veuillez entrer une adresse e-mail valide';
      }
    } else {
      return 'Veuillez entrer une adresse e-mail';
    }
  }

  Widget _buildInscriptionForm() {
    return Form(
      key: formKey,
      child: SizedBlock(
        height: height * 7.3,
        width: width * 1.1,
        percentRadius: 0.03,
        clickEvent: () {  },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTextFormField("Nom :", "Entrez votre nom"),
              _buildTextFormField("Prénom :", "Entrez votre prénom"),
              _buildTextFormField("E-mail :", "Entrez votre e-mail"),
              _buildTextFormField("Nom d'utilisateur :", "Entrez votre nom d'utilisateur"),
              _buildTextFormField("Mot de passe :", "Choisissez un mot de passe"),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 14.0),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Confirmez votre mot de passe",
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 14),
                validator: (value) {},
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
                        if (formKey.currentState!.validate()) {
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text("Je m\'inscris")
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
      key: formKey,
      child: SizedBlock(
        height: height * 4,
        width: width * 1.1,
        percentRadius: 0.03,
        clickEvent: () {  },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTextFormField("Nom d'utilisateur :", "Entrez votre nom d'utilisateur"),
              _buildTextFormField("Mot de passe :", "Entrez votre mot de passe"),
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
                        if (formKey.currentState!.validate()) {
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
