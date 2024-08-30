import 'dart:async';

Future<Map<String, dynamic>> generateFakeQuiz({
  int numQuestions = 3,
  int numPropositions = 4,
  int delay = 2,
}) async {
  return Future.delayed(Duration(seconds: delay), () {
    Map<String, dynamic> quiz = {
      "Quiz_id": "1",
      "Quiz_name": "Quiz 1",
      "Questions": List.generate(numQuestions, (questionIndex) {
        return {
          "Question_id": (questionIndex + 1).toString(),
          "Question_text": "Question ${questionIndex + 1}",
          "Propositions": List.generate(numPropositions, (propositionIndex) {
            return {
              "Proposition_id": (propositionIndex + 1).toString(),
              "Proposition_text": "Proposition ${propositionIndex + 1}",
              "Is_correct": propositionIndex == 0 ? "true" : "false"
            };
          })
        };
      })
    };

    return quiz;
  });
}