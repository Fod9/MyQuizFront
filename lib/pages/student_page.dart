import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/quiz/dropdown/dropdown_quiz.dart' show DropDownQuiz;
import 'package:my_quiz_ap/helpers/quiz/get_quiz_list.dart' show getQuizList;

import '../components/stats/statistics.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {

  late final Future<List<Map<String, dynamic>>> _blocList;

  @override
  void initState() {
    super.initState();
    _blocList = getQuizList();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _blocList, // list of all subjects
        builder: (context, snapshot) {
          if (snapshot.hasError) {  // if an error occurred return an error message

            return Center(
              child: Text("An error occurred, please try again later ${snapshot.error}"),
            );

          } else if (snapshot.connectionState == ConnectionState.done) {

            // check if the screen is mobile or desktop
            final bool isMobile = MediaQuery.of(context).size.width < 600;

            // if the response contains an error display it
            if (snapshot.data!.isNotEmpty && snapshot.data![0].containsKey("error")) {
              return Center(
                child: Text(snapshot.data![0]["error"]),
              );
            }

            // display according to the screen size
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

            // if the response is not done, display a loading spinner
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


/// Display the list of blocs for mobile.
/// All is in a [Column].
/// - [width] is the width of the screen
/// - [height] is the height of the bloc
/// - [expendedHeight] is the height of the expanded header
/// - [blocList] is the list of subjects
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

  /// Display the list of blocs
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
          const StatisticsBlock(height: 400, width: 330, mode: "mobile"),
          ..._blocWidgets
        ],
      ),
    );
  }
}

/// Display the list of blocs for desktop.
/// All is in a [Wrap].
/// - [width] is the width of the screen
/// - [height] is the height of the bloc
/// - [expendedHeight] is the height of the expanded header
/// - [blocList] is the list of subjects
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
        padding: const EdgeInsets.only(top:45),
        child: Column(
          children: [
            const StatisticsBlock(height: 400, width: 330, mode: "desktop", isExpandable: false, isExpanded: true),
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
