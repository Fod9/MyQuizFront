import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_quiz_ap/constants.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/components/Forms/FormController.dart' show FormController;
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:my_quiz_ap/pages/teacher_page.dart';
import 'package:my_quiz_ap/helpers/jwt.dart';

class AuthBtn extends StatefulWidget {

  const AuthBtn({
    super.key,
    required this.formKeyInscription,
    required this.formKeyConnexion,
    required this.formController,
    required this.formType,
    required this.setErrorMessage,
  });

  final GlobalKey<FormState> formKeyInscription;
  final GlobalKey<FormState> formKeyConnexion;
  final FormController formController;
  final String formType;
  final Function(String) setErrorMessage;

  @override
  State<AuthBtn> createState() => _AuthBtnState();
}

class _AuthBtnState extends State<AuthBtn> {

  bool _loading = false;
  final Color effectColor = lightGlassBlue.withOpacity(0.4);
  final JWT jwt = JWT();
  final JWTR jwtr = JWTR();

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
        Uri.parse('$apiUrl/connection/signin'),
        body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json",
        },
      );

      dynamic data;

      if (response.error) {
        widget.setErrorMessage(response.body);
        printError("${response.statusCode} - ${response.body}");
        setState(() {
          _loading = false;
        });
        return;
      } else {
        data = jsonDecode(response.body);
        printInfo(data.toString());
      }

      String token = data["access_token"] ?? "";
      String refreshToken = data["refresh_token"] ?? "";

      // Write the token to the device
      if (token.isNotEmpty) {
        await jwt.write(token);

        if (kDebugMode) {
          printInfo("Token successfully written");
          printInfo(await jwt.read());
        }

      } else {
        if (kDebugMode) printError("Token is empty");
      }

      // Write the token to the device
      if (refreshToken.isNotEmpty) {
        await jwtr.write(refreshToken);

        if (kDebugMode) {
          printInfo("Refresh Token successfully written");
          printInfo(await jwtr.read());
        }

      } else {
        if (kDebugMode) printError("Refresh Token is empty");
      }

    } else {
      if (kDebugMode) {
        printError("Form data is null");
      }
    }

    setState(() {
      _loading = false;
    });


    // TODO : fix navigation depending on the user type and screen type
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/');
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
