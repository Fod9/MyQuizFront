import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/appbar/appbar_menu_button.dart';
import 'package:my_quiz_ap/components/appbar/appbar_text_button.dart';
import 'package:my_quiz_ap/components/appbar/drawer_trial_button.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart';
import 'package:my_quiz_ap/helpers/utils.dart';

/// MyQuizNavbar is the navbar of the MyQuiz page.
class MyQuizAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyQuizAppBar({
    super.key,
    this.title = 'My Quiz',
    this.userRole,
    required this.scaffoldKey,
  });

  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? userRole;

  @override
  State<MyQuizAppBar> createState() => _MyQuizAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(90.0);
}

class _MyQuizAppBarState extends State<MyQuizAppBar> {

  final JWT jwt = JWT();

  @override
  Widget build(BuildContext context) {

    Widget userRolePage() {
      switch (widget.userRole) {
        case 'admin':
          return const AppbarTextButton(text:'Admin', route: '/admin', color: Colors.white);
        case 'teacher':
          return const AppbarTextButton(text:'Gérer les quiz', route: '/teacher', color: Colors.white);
        case 'student':
          return const AppbarTextButton(text:'Quiz', route: '/student', color: Colors.white);
        case 'school':
          return const AppbarTextButton(text:'Gérer votre établissement', route: '/school', color: Colors.white);
        default:
          return const SizedBox.shrink();
      }
    }

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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Navigator.canPop(context) ? SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ) : const SizedBox.shrink(),

                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              FutureBuilder(
                  future: jwt.isLogged,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!) {
                        return MediaQuery.of(context).size.width < 685 ?
                          AppbarMenuButton(scaffoldKey: widget.scaffoldKey)
                              :
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const AppbarTextButton(route: '/home', text: 'Accueil', color: Colors.white),

                                const SizedBox(width: 10.0),

                                userRolePage(),

                                const SizedBox(width: 10.0),

                                const AppbarTextButton(route: '/logout', text: 'Déconnexion', color: Colors.white),
                              ],
                            ),
                          );
                      } else {
                        return MediaQuery.of(context).size.width < 685 ?
                          AppbarMenuButton(scaffoldKey: widget.scaffoldKey)
                              :
                          const Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppbarTextButton(route: '/home', text: 'Accueil', color: Colors.white),

                                SizedBox(width: 10.0),

                                AppbarTextButton(route: '/auth', text: 'Inscription/Connexion', color: Colors.white),

                                SizedBox(width: 10.0),

                                DrawerTrialButton(),
                              ],
                            ),
                          );
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}