import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Forms/CustomForm.dart';
import 'package:my_quiz_ap/pages/auth/login_btn.dart';
import '../../helpers/Colors.dart';
import '../../components/Forms/FormController.dart';

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

  final FormController formController = FormController();

  final formKeyInscription = GlobalKey<FormState>();
  final formKeyConnexion = GlobalKey<FormState>();

  void handleFormSubmit(String formType) {
    if (formType == "inscription") {
      if (formKeyInscription.currentState!.validate()) {
        // Form submission logic for inscription form
        Map<String, String> data = formController.getData();
      }
    } else {
      if (formKeyConnexion.currentState!.validate()) {
        // Form submission logic for connexion form
        Map<String, String> data = formController.getData();
      }
    }
  }

  // This code allow FormController to react to changes in the form fields

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            isLoginFormDisplayed
                ? CustomForm(
                height: height,
                width: width,
                formController: formController,
                mode:FormMode.register)
                : CustomForm(
                height: height,
                width: width,
                formController: formController,
                mode: FormMode.login),
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
                  child: Text(isLoginFormDisplayed
                      ? "Je n'ai pas de compte"
                      : "J'ai déjà un compte"),
                ),
              ),
            ),

            LoginBtn(
                formData: formController.getData(),
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
    return const Center();
  }
}
