import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown/dropdown_quiz.dart';
import 'package:my_quiz_ap/fakers/fake_quiz_list.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key, required this.screenType});

  final String screenType;

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  double _width = 300;
  double _height = 150;

  late final Future<List<Map<String, dynamic>>> _blocList;

  @override
  void initState() {
    super.initState();
    _blocList = getFakeQuizList(
      subjectCount: 3,
      quizCount: 5,
      throwError: false,
      delay: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.screenType == "mobile" ) {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return FutureBuilder(
        future: _blocList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {

            return const Center(
              child: Text("An error occurred, please try again later"),
            );

          } else if (snapshot.connectionState == ConnectionState.done) {

            return (widget.screenType == "mobile" || _width > 600)
                ? MobileDisplay(
              width: _width,
              height: _height,
              blocList: snapshot.data!,
            )
                : DesktopDisplay(
                width: _width,
                height: _height
            );

          } else {

            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeCap: StrokeCap.round,
                    )
                ),
              ),
            );

          }

        }
    );
  }
}

class MobileDisplay extends StatelessWidget {
  const MobileDisplay({
    super.key,
    required this.width,
    required this.height,
    required this.blocList,
  });

  final double width;
  final double height;
  final List<Map<String, dynamic>> blocList;

  Iterable<Widget> get _blocWidgets sync* {
    for (var bloc in blocList) {
      yield DropDownQuiz(
        blockName: bloc["name"],
        height: height,
        width: width,
        mode: "teacher",
        quizList: bloc["quizList"]!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ..._blocWidgets
        ],
      ),
    );
  }
}

class DesktopDisplay extends StatelessWidget {
  const DesktopDisplay({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [

            ],
          ),
        ],
      ),
    );
  }
}
