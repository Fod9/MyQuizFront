import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/appbar/appbar_menu_button.dart';
import 'package:my_quiz_ap/pages/auth/tmp_logout_btn.dart' show TmpLogoutBtn;

/// MyQuizNavbar is the navbar of the MyQuiz page.
class MyQuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyQuizAppBar({
    Key? key,
    this.title = 'My Quiz',
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0x6AFFFFFF),
          borderRadius: BorderRadius.circular(200),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 15.0,
              spreadRadius: -5.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 10.0,
            top: 10.0,
            bottom: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                  color: Color(0xFFFFFFFF),
                ),
              ),

              const Spacer(),

              const AppbarMenuButton()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90.0);
}