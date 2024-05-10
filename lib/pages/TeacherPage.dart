import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/dropdown/dropdown_quiz.dart' show DropDownQuiz;
import 'package:my_quiz_ap/fakers/fake_quiz_list.dart' show getFakeQuizList;

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {

  late final Future<List<Map<String, dynamic>>> _blocList;

  @override
  void initState() {
    super.initState();
    _blocList = getFakeQuizList(
      subjectCount: 5,
      quizCount: 5,
      throwError: false,
      delay: 1,
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _blocList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {

            return const Center(
              child: Text("An error occurred, please try again later"),
            );

          } else if (snapshot.connectionState == ConnectionState.done) {

            final bool isMobile = MediaQuery.of(context).size.width < 600;

            if (isMobile) {
              return MobileDisplay(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 55,
                expendedHeight: 140,
                blocList: snapshot.data!,
              );
            } else {
              return DesktopDisplay(
                  width: 410,
                  height: 140,
                  expendedHeight: 210,
                  blocList: snapshot.data!
              );
            }
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
    required this.expendedHeight,
    required this.blocList,
  });

  final double width, height, expendedHeight;
  final List<Map<String, dynamic>> blocList;

  Iterable<Widget> get _blocWidgets sync* {
    for (var bloc in blocList) {
      yield DropDownQuiz(
        blockName: bloc["name"],
        height: height,
        expandedHeight: 140,
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

  const DesktopDisplay({
    super.key,
    required this.width,
    required this.height,
    required this.expendedHeight,
    required this.blocList,
  });

  final double width, height, expendedHeight;
  final List<Map<String, dynamic>> blocList;

  Iterable<Widget> get _blocWidgets sync* {
    for (var bloc in blocList) {
      yield Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        child: DropDownQuiz(
          blockName: bloc["name"],
          height: height,
          expandedHeight: expendedHeight,
          width: width,
          mode: "teacher",
          radius: 30,
          quizList: bloc["quizList"]!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top:75),
        child: Column(
          children: [
            Wrap(
              spacing: 100,
              runSpacing: 75,
              children: [
                ..._blocWidgets,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
