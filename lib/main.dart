import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:my_quiz_ap/pages/manage_students_page.dart' show ManageStudentsPage;
import 'package:my_quiz_ap/pages/home_page.dart' show HomePage;
import 'package:my_quiz_ap/pages/auth_page.dart' show AuthPage;
import 'package:my_quiz_ap/pages/admin_page.dart' show AdminPage;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:my_quiz_ap/pages/create_quiz_page.dart' show CreateQuizPage;
import 'package:my_quiz_ap/pages/quiz_page.dart' show QuizPage;
import 'package:my_quiz_ap/pages/school_page.dart' show SchoolPage;
import 'package:my_quiz_ap/pages/teacher_page.dart' show TeacherPage;
import 'package:my_quiz_ap/pages/landing_router.dart' show LandingRouter;
import 'package:my_quiz_ap/pages/student_page.dart' show StudentPage;
import 'package:my_quiz_ap/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'helpers/Colors.dart' show lightGlassBlue;
import 'layout.dart' show Layout;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]).then((_) {
      runApp(const MyQuizApp());
    });
  } else {
    runApp(const MyQuizApp());
  }
}

class MyQuizApp extends StatelessWidget {
  const MyQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
          title: 'MyQuiz',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: lightGlassBlue,
            useMaterial3: true,
            fontFamily: 'Quicksand',
          ),

          // initial route is the landing router page
          // the landing router page will redirect to the correct page
          initialRoute: '/',

          routes: {
            '/': (context) => const Layout("MyQuiz", page: LandingRouter(), hasAppBar: false),
            '/home': (context) => const Layout("MyQuiz", page: HomePage(), hasAppBar: true, hasTopOffset: false),
            '/auth': (context) => const Layout("MyQuiz", page: AuthPage(), hasAppBar: true),
            '/logout': (context) => const Layout("MyQuiz", page: LandingRouter(logout: true), hasAppBar: false),
            '/admin': (context) => const Layout("Admin", page: AdminPage()),
            '/teacher': (context) => const Layout("Teacher", page: TeacherPage()),
            '/student': (context) => const Layout("Student", page: StudentPage()),
            '/school': (context) => const Layout("School", page: SchoolPage()),
            '/quiz': (context) => const Layout("Quiz", page: QuizPage()),
            '/create-quiz': (context) => const Layout("Create Quiz", page: CreateQuizPage()),
            '/modify-quiz': (context) => const Layout("Modify Quiz", page: CreateQuizPage(isModify: true)),
            '/manage-students': (context) => const Layout("Manage Students", page: ManageStudentsPage()),
          }
      ),
    );
  }
}