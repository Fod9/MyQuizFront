import 'package:flutter/material.dart';
import 'package:my_quiz_ap/pages/auth/store_auth_token.dart' show AuthToken;
import 'package:my_quiz_ap/helpers/utils.dart' show printInfo;

class TmpLogoutBtn extends StatefulWidget {
  const TmpLogoutBtn({super.key});

  @override
  State<TmpLogoutBtn> createState() => _TmpLogoutBtnState();
}

class _TmpLogoutBtnState extends State<TmpLogoutBtn> {

  IconData _icon = Icons.logout_rounded;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          setState(() {
            _icon = Icons.hourglass_full_rounded;
          });
          await AuthToken.delete();
          printInfo('JWT Token deleted');
          setState(() {
            _icon = Icons.logout_rounded;
          });

          if (context.mounted) Navigator.pushReplacementNamed(context, '/');
        },
        icon: Icon(_icon),
    );
  }
}
