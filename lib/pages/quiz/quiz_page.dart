import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/questions/quiz_body.dart';
import 'package:my_quiz_ap/helpers/quiz/get_quiz.dart';


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
            return QuizBody(
              quiz: snapshot.data!,
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
