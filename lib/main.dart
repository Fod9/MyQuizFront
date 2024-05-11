import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:my_quiz_ap/pages/AdminPage.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:my_quiz_ap/pages/TeacherPage.dart' show TeacherPage;
import 'package:my_quiz_ap/pages/auth/tmp_logout_btn.dart';
import 'package:my_quiz_ap/pages/landing_router.dart';
import 'package:my_quiz_ap/pages/studentPage.dart' show StudentPage;
import 'package:my_quiz_ap/pages/auth/auth_page.dart' show AuthPage;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(const MyQuizApp());
  });
}

class MyQuizApp extends StatelessWidget {
  const MyQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyQuiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',

      routes: {
        '/': (context) => const Layout("MyQuiz", page: LandingRouter(), hasAppBar: false),
        '/auth': (context) => const Layout("MyQuiz", page: AuthPage(), hasAppBar: false),
        '/admin': (context) => const Layout("Admin", page: AdminPage()),
        '/teacher': (context) => const Layout("Teacher", page: TeacherPage()),
        '/student': (context) => const Layout("Student", page: StudentPage()),
      }
    );
  }
}

class Layout extends StatefulWidget {
  const Layout(
    this.title,
    {
      super.key,
      required this.page,
      this.hasAppBar = true,
    }
  );

  final String title;
  final Widget page;
  final bool hasAppBar;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {

  @override
  Widget build(BuildContext context) {

    String screenType = getScreenType(context);

    return SafeArea(
      bottom: false,
      child: Scaffold(
          appBar: widget.hasAppBar ? AppBar(
            title: Text(widget.title),
            actions: [

              const TmpLogoutBtn(),

              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          ) : null,
          body: Stack(
            children: [
              SizedBox.expand(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // switch background with type
                          image: (screenType == "mobile")
                              ? const AssetImage(
                              "assets/images/BackgroundMobile.png")
                              : const AssetImage(
                              "assets/images/BackgroundDesktop.png"),
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
              ),
      
              SingleChildScrollView(
                child: widget.page,
              ),
            ],
          )
      ),
    );
  }
}
