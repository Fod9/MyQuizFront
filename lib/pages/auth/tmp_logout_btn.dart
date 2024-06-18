import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT, JWTR;
import 'package:my_quiz_ap/helpers/utils.dart' show printInfo;

class TmpLogoutBtn extends StatefulWidget {
  const TmpLogoutBtn({
    super.key,
    this.size = 50.0,
  });

  final double size;

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
    final JWTR jwtr = JWTR();

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: IconButton(
        onPressed: () async {
          // small fancy animation
          setState(() {
            _icon = Icons.hourglass_full_rounded;
          });

          // delete the token
          await jwt.delete();
          printInfo('JWT Token deleted');
          await jwtr.delete();
          printInfo('JWTR Token deleted');

          // end of fancy animation
          setState(() {
            _icon = Icons.logout_rounded;
          });

          // redirection to the auth page
          if (context.mounted) Navigator.pushReplacementNamed(context, '/');
        },

        alignment: Alignment.center,
        padding: EdgeInsets.zero,

        icon: Icon(
          _icon,
          size: widget.size/2,
        ),
      ),
    );
  }
}
