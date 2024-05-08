import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/components/Forms/FormController.dart' show FormController;
import 'package:http/http.dart' as http;
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

  void handleLogin() async {
    setState(() {
      _loading = true;
    });

    final Map<String, String>? formData = getFormData(widget.formType);

    print(formData);

    if (formData != null) {

      final Map<String, String> requestBody = {
        "email": formData["email"]!,
        "password": formData["mdp"]!,
      };

      final http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/connection/signin'),
        body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (kDebugMode) print(response.body);

      var data = jsonDecode(response.body);

      String token = data["token"] ?? "";

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
  }

  Map<String, String>? getFormData(String formType) {
    if (formType == "inscription") {
      if (widget.formKeyInscription.currentState!.validate()) {
        // Form submission logic for inscription form
        print("inscription");
        return widget.formController.getData();
      }
      return null;
    } else {
      if (widget.formKeyConnexion.currentState!.validate()) {
        // Form submission logic for connexion form
        print("login");
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
          )
        ),
    );
  }
}
