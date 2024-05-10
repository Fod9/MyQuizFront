import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Forms/CustomForm.dart' show CustomForm, FormMode;
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:my_quiz_ap/pages/auth/auth_btn.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show darkGlass;
import 'package:my_quiz_ap/components/Forms/FormController.dart' show FormController;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  double _width = 300;
  double _height = 150;
  String authType = "inscription";
  bool isLoginFormDisplayed = false;

  final FormController formController = FormController();

  String errorMessage = "";

  final GlobalKey<FormState> formKeyInscription = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyConnexion = GlobalKey<FormState>();

  void setErrorMessage(String message) => setState(() {errorMessage = message;});

  @override
  void initState() {
    super.initState();
    formController.addListener(_update);
  }

  void _update() {
    setState(() {});
  }

  @override
  void dispose() {
    formController.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String screenType = getScreenType(context);

    if (screenType == "mobile") {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return (screenType == "mobile" || _width > 600) ?
      MobileDisplay(
        width: _width,
        height: _height,
        toggleForm: toggleForm,
        isLoginFormDisplayed: isLoginFormDisplayed,
        formController: formController,
        setErrorMessage: setErrorMessage,
        errorMessage: errorMessage,
      )
        :
      DesktopDisplay(
        width: _width,
        height: _height
      );
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
    required this.setErrorMessage,
    required this.errorMessage,
  }) : super(key: key);

  final double width;
  final double height;
  final void Function() toggleForm;
  final bool isLoginFormDisplayed;
  final FormController formController;
  final String errorMessage;
  final Function(String) setErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            isLoginFormDisplayed ?
              CustomForm(
                height: height,
                width: width,
                formController: formController,
                mode: FormMode.register,
                errorMessage: errorMessage,
              )
                :
              CustomForm(
                height: height,
                width: width,
                formController: formController,
                mode: FormMode.login,
                errorMessage: errorMessage,
              ),

            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (width * 0.75).clamp(150, 350),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: AuthBtn(
                      formKeyInscription: formController.formKeyInscription,
                      formKeyConnexion: formController.formKeyConnexion,
                      formController: formController,
                      formType: isLoginFormDisplayed ? "inscription" : "connexion",
                      setErrorMessage: setErrorMessage,
                    ),
                  ),

                  MaterialButton(
                    onPressed: toggleForm,
                    color: darkGlass,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: height * 0.6,
                    minWidth: width * 0.6,
                    child: Text(
                      isLoginFormDisplayed ? "J'ai déjà un compte" : "Je n'ai pas de compte",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Quicksand"
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    return const Center();
  }
}
