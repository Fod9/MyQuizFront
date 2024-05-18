import 'package:flutter/material.dart';
import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http show Response, get;
import 'package:my_quiz_ap/components/Quiz/dropdown/dropdown_quiz.dart' show DropDownQuiz;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/quiz_list_format.dart';
import 'package:my_quiz_ap/helpers/utils.dart' show printError, printInfo;
import 'package:my_quiz_ap/helpers/http_extensions.dart';

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
    _blocList = getQuizList();
  }

  Future<List<Map<String, dynamic>>> getQuizList({int retryCount = 0}) async {
    final JWT jwt = JWT();
    final String token = await jwt.read();

    final Future<http.Response> fResponse = http.get(
      Uri.parse('$apiUrl/quiz/list'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token,
      },
    );

    final http.Response response = await fResponse;

    if (response.error) {
      if (retryCount >= 3) { // Limit the number of retries to 3
        printError("Unauthorized request, maximum retries exceeded");
        return Future.value([{"error": "Unauthorized request, maximum retries exceeded"}]);
      } else {
        printError("Unauthorized request, retrying...");
        return getQuizList(retryCount: retryCount + 1);
      }
    } else if (response.ok) {
      final data = jsonDecode(response.body);
      printInfo(data.toString());

      final List<Map<String, dynamic>> formattedQuizList = quizListFormat(data);
      printInfo(formattedQuizList.toString());

      return formattedQuizList;
    } else {
      printError("${response.statusCode} - ${response.body}");
      return Future.value([{"error": "An error occurred, please try again later"}]);
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _blocList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {

            return Center(
              child: Text("An error occurred, please try again later ${snapshot.error}"),
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
