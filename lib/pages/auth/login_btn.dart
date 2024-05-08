import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart' show lightGlassBlue;

class LoginBtn extends StatefulWidget {

  const LoginBtn({
    super.key,
    required this.formData,
  });

  final Map<String, String> formData;

  @override
  State<LoginBtn> createState() => _LoginBtnState();
}

class _LoginBtnState extends State<LoginBtn> {

  bool _loading = false;
  final Color effectColor = lightGlassBlue.withOpacity(0.4);

  void handleLogin() {
    setState(() {
      _loading = true;
    });

    // Login logic
    print(widget.formData);
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
        const Text(
            "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Quicksand"
          )
        ),
    );
  }
}
