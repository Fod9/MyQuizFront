import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_body.dart' show QuizBody;
import 'package:my_quiz_ap/helpers/quiz/get_quiz.dart' show getQuiz;
import 'package:my_quiz_ap/helpers/utils.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  late final args = ModalRoute.of(context)!.settings.arguments;
  late final Future<Map<String, dynamic>> _fQuiz = getQuiz(args as int);

  int score = 0;
  int total = 0;

  void addScore(int toAdd) {
    printInfo("Adding $toAdd to the score");
    score += toAdd;
    printInfo("New score: $score");
  }

  List<int> getScore() => [score, total];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fQuiz,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred, please try again later ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {

            total = snapshot.data!['Questions'].length.toInt();

            return QuizBody(
              quiz: snapshot.data!,
              addScore: addScore,
              getScore: getScore,
            );
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
    );
  }
}
