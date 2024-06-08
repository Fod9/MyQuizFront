import 'package:flutter/material.dart';
import 'package:my_quiz_ap/pages/homePage.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MyQuiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _screenType = "mobile";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          _screenType = "desktop";
        } else {
          _screenType = "mobile";
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Container(
                  color: Colors.white.withOpacity(0.35),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        // fontFamily: GoogleFonts.quicksand().fontFamily,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                        },
                        icon: Image.asset(
                          'assets/images/menu-burger.png', 
                          width:
                              24, 
                          height:
                              24, 
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (_screenType == "mobile")
                        ? const AssetImage("assets/images/BackgroundMobile.png")
                        : const AssetImage(
                            "assets/images/BackgroundDesktop.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: HomePage(
                  screenType: _screenType,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
