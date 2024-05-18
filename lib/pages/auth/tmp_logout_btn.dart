import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/utils.dart' show printInfo;

class TmpLogoutBtn extends StatefulWidget {
  const TmpLogoutBtn({super.key});

  @override
  State<TmpLogoutBtn> createState() => _TmpLogoutBtnState();
}

/// this widget is used to log out the user
/// it deletes the token from the device
/// and redirects the user to the auth page
///
/// only used for testing purposes in the app bar
class _TmpLogoutBtnState extends State<TmpLogoutBtn> {

  IconData _icon = Icons.logout_rounded;

  @override
  Widget build(BuildContext context) {

    final JWT jwt = JWT();

    return IconButton(
        onPressed: () async {
          // small fancy animation
          setState(() {
            _icon = Icons.hourglass_full_rounded;
          });

          // delete the token
          await jwt.delete();
          printInfo('JWT Token deleted');

          // end of fancy animation
          setState(() {
            _icon = Icons.logout_rounded;
          });

          // redirection to the auth page
          if (context.mounted) Navigator.pushReplacementNamed(context, '/');
        },
        icon: Icon(_icon),
    );
  }
}
