import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/get_screen_type.dart';
import 'package:my_quiz_ap/pages/AdminPage.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:my_quiz_ap/pages/TeacherPage.dart' show TeacherPage;
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
        '/': (context) => const Layout("MyQuiz", page: AuthPage()),
        '/admin': (context) => const Layout("Admin", page: AdminPage()),
        '/teacher': (context) => const Layout("Teacher", page: TeacherPage()),
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
    }
  );

  final String title;
  final Widget page;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {

  @override
  Widget build(BuildContext context) {

    String screenType = getScreenType(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
              },
            ),
          ],
        ),
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
    );
  }
}
