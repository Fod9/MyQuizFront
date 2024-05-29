import 'package:flutter/material.dart';
import 'package:my_quiz_ap/fakers/fake_quiz.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  late final args = ModalRoute.of(context)!.settings.arguments;
  final Future<Map<String, dynamic>> _fQuiz = generateFakeQuiz();

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
            return Center(
              child: Column(
                children: [
                  Text("Quiz: ${snapshot.data!["Quiz_name"]}"),

                  for (var question in snapshot.data!["Questions"])
                    Column(
                      children: [
                        Text("Question: ${question["Question_text"]}"),
                        for (var proposition in question["Propositions"])
                          Text("Proposition: ${proposition["Proposition_text"]}"),
                      ],
                    ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
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
