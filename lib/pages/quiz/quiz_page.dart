import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_body.dart' show QuizBody;
import 'package:my_quiz_ap/constants.dart';
import 'package:my_quiz_ap/helpers/get_user_info.dart';
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart';
import 'package:my_quiz_ap/helpers/quiz/get_quiz.dart' show getQuiz;
import 'package:my_quiz_ap/helpers/utils.dart' show printError, printInfo;
import 'package:my_quiz_ap/providers/quiz_data.dart' show QuizData;
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;
import 'package:http/http.dart' as http show Response, get;


class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  late final Object? args;  // used here to store the id of the quiz
  late final Future<Map<String, dynamic>> _fQuiz;  // the future quiz data
  late Map<String, dynamic> _userInfo;
  bool _isLoaded = false;

  Future<Map<String, dynamic>> _loadQuiz() async {

    Map<String, dynamic> userInfo = await getUserInfo();

    if (userInfo.containsKey("error")) {
      printError(userInfo["error"]!);
      return Future.value({"error": "An error occurred, please try again later"});
    } else {
      _userInfo = userInfo;
      return getQuiz(args as int);
    }
  }

  @override
  Widget build(BuildContext context) {

    if (!_isLoaded) {
      args = ModalRoute.of(context)!.settings.arguments;
      _fQuiz = _loadQuiz();
      _isLoaded = true;
    }

    return ChangeNotifierProvider(
      create: (context) => QuizData(),
      child: FutureBuilder(
          future: _fQuiz,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              printError(snapshot.error.toString());
              return Center(
                child: Text("An error occurred, please try again later ${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {

              WidgetsBinding.instance.addPostFrameCallback((_) {
                QuizData quizData = Provider.of<QuizData>(context, listen: false);
                quizData.setTotal(snapshot.data!['Questions'].length);
                quizData.setQuizId(snapshot.data!['Quiz_id'] as int);
                quizData.setUserId(_userInfo['id'] as int);

                printInfo("QuizData: $quizData");
              });

              return QuizBody(quiz: snapshot.data!);

            } else {

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Chargement du quiz...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      CircularProgressIndicator(
                        color: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeCap: StrokeCap.round,
                      ),
                    ],
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
