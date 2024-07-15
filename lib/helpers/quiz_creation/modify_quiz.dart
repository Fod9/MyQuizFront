import 'dart:convert' show jsonEncode;
import 'package:http/http.dart' as http show Response, post;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart' show checkToken;
import 'package:my_quiz_ap/helpers/quiz_creation/quiz_data_formatter.dart';
import 'package:my_quiz_ap/helpers/utils.dart' show printError, printOrder, printSuccess;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;


Future<bool> modifyQuiz(QuizCreationData quizData) async {

  final JWT jwt = JWT();

  final Map<String, dynamic> quizDataFormated = quizData.backendFormatForUpdate;

  // printOrder(jsonEncode(quizDataFormated));
  printOrder("Updating quiz on the server...");

  Future<http.Response> fResponse() async => http.post(
    Uri.parse('$apiUrl/quiz/create/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': await jwt.read(),
    },
    body: jsonEncode(quizDataFormated),
  );

  final http.Response response = await checkToken(fResponse);

  if (response.error) {
    printError("createQuiz Error: ${response.body}");
    return false;
  } else {
    printSuccess("Quiz created successfully!");
    return true;
  }
}