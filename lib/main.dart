import 'package:flutter/material.dart';
import 'package:my_quiz_ap/pages/studentPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            title: Text(widget.title),
          ),
          body: Stack(
            children: [
              Container(
                // width and height are set to double.infinity
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // switch background with type
                      image: (_screenType == "mobile")
                          ? const AssetImage(
                          "assets/images/BackgroundMobile.png")
                          : const AssetImage(
                          "assets/images/BackgroundDesktop.png"),
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              SingleChildScrollView(
                child: StudentPage(screenType: _screenType,),
              ),
            ],
          )
      );
    },
    );
  }
}
