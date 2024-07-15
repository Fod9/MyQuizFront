import 'package:my_quiz_ap/helpers/quiz_creation/question_data_formatter.dart' show QuestionDataFormatter;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;


extension QuizDataFormatter on QuizCreationData {
  Map<String, dynamic> get backendFormat {
    final Map<String, dynamic> formatedQuiz = <String, dynamic>{
      "name" : quizName,
      "matiere" : selectedSubject?["name"] ?? -1,
      "created_by" : userId,
    };

    formatedQuiz['created_at'] = DateTime.now().toIso8601String().substring(0, 10);

    final List<int> formatedClasses = [];

    for (final class_ in selectedClasses) {
      formatedClasses.add(class_["id"]);
    }

    formatedQuiz["classes"] = formatedClasses;

    final List<Map<String, dynamic>> formatedQuestions = [];

    for (final question in questions) {
      formatedQuestions.add(question.backendFormat);
    }

    formatedQuiz["questions"] = formatedQuestions;

    return formatedQuiz;
  }

  Map<String, dynamic> get backendFormatForUpdate {
    final Map<String, dynamic> formatedQuiz = backendFormat;

    formatedQuiz["quiz_id"] = quizId;

    return formatedQuiz;
  }
}