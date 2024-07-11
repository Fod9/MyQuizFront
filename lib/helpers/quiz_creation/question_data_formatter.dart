import 'package:my_quiz_ap/providers/question_creation_data.dart' show Proposition, QuestionCreationData;


extension QuestionDataFormatter on QuestionCreationData {

  /// Format the question data to be sent to the backend
  Map<String, dynamic> get backendFormat {

    // initial question data
    final Map<String, dynamic> formatedQuestion = <String, dynamic>{
      "Nom" : name,
      "Difficulte" : difficulty,
    };

    // propositions data
    final List<Map<String,dynamic>> formatedProps = [];

    // format propositions
    for (final Proposition prop in propositions) {
      formatedProps.add({
        "Nom" : prop.text,
        "Correcte" : prop.isCorrect,
      });
    }

    // add propositions to the question data
    formatedQuestion["Propositions"] = formatedProps;

    return formatedQuestion;
  }
}