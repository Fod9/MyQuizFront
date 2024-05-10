import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/components/Forms/FormController.dart' show FormController;
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/pages/TeacherPage.dart';
import 'package:my_quiz_ap/pages/auth/store_auth_token.dart';

class AuthBtn extends StatefulWidget {

  const AuthBtn({
    super.key,
    required this.formKeyInscription,
    required this.formKeyConnexion,
    required this.formController,
    required this.formType,
  });

  final GlobalKey<FormState> formKeyInscription;
  final GlobalKey<FormState> formKeyConnexion;
  final FormController formController;
  final String formType;

  @override
  State<AuthBtn> createState() => _AuthBtnState();
}

class _AuthBtnState extends State<AuthBtn> {

  bool _loading = false;
  final Color effectColor = lightGlassBlue.withOpacity(0.4);

  /// Handles the login logic
  /// it sends a POST request to the server
  /// with the user's email and password
  /// if the request is successful, it writes the token to the device
  /// and navigates to the home page
  void handleLogin() async {
    setState(() {
      _loading = true;
    });

    final Map<String, String>? formData = getFormData(widget.formType);

    if (kDebugMode) print(formData);


    if (formData != null) {

      // end autofill context
      TextInput.finishAutofillContext();

      final Map<String, String> requestBody = {
        "email": formData["email"]!,
        "password": formData["mdp"]!,
      };

      // Send a POST request to the server to login the user
      final http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/connection/signin'),
        body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (kDebugMode) print(response.body);

      final data = jsonDecode(response.body);

      String token = data["token"] ?? "";

      // Write the token to the device
      if (token.isNotEmpty) {
        await AuthToken.write(token);

        if (kDebugMode) {
          print("Token successfully written");
          print(await AuthToken.read());
        }

      } else {
        if (kDebugMode) print("Token is empty");
      }

    } else {
      if (kDebugMode) {
        print("Form data is null");
      }
    }

    setState(() {
      _loading = false;
    });


    // TODO : fix navigation depending on the user type and screen type
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TeacherPage(),
        ),
      );
    }
  }

  /// Returns the form data if the form is valid
  /// otherwise it returns null
  Map<String, String>? getFormData(String formType) {
    // Check if the form is valid
    if (formType == "inscription") {
      if (widget.formKeyInscription.currentState!.validate()) {
        if (kDebugMode) print("inscription");
        return widget.formController.getData();
      }
      return null;
    } else {
      if (widget.formKeyConnexion.currentState!.validate()) {
        if (kDebugMode) print("login");
        return widget.formController.getData();
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: handleLogin,

      color: const Color(0x66000000),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      splashColor: effectColor,
      focusColor: effectColor,
      hoverColor: effectColor,
      highlightColor: effectColor,
      colorBrightness: Brightness.light,

      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),


      // display a circular progress indicator if the button is pressed
      // and the request is being processed
      // otherwise display the button text
      child: _loading ?
        const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeCap: StrokeCap.round,
            )
        )
          :
        Text(
          widget.formType == "inscription" ? "S'inscrire" : "Se connecter",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Quicksand"
          ),
        ),
    );
  }
}
