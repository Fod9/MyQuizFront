import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart' show checkToken;
import 'package:my_quiz_ap/helpers/utils.dart' show printError;

Future<Map<String, dynamic>> getStats() async {
  JWT jwt = JWT();
  double averageNote = 0.0;
  int timeElapsed = 0;
  double percentageDoneQuizzes = 0.0;

  Future<http.Response> fResponse() async =>
      http.get(
        Uri.parse('$apiUrl/student/statistics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': await jwt.read(),
        },
      );

  final http.Response response = await checkToken(fResponse);

  if (response.error) {
    printError("getStats Error: ${response.body}");
    return {
      "error": "An error occurred, please try again later"
    };
  } else {
    dynamic data = jsonDecode(response.body);
    averageNote = data["averageNote"] * 1.0;
    timeElapsed = data["timeElapsed"] as int;
    percentageDoneQuizzes = data["percentageOfDoneQuizzes"] * 1.0;

    return {
      "average_note": averageNote,
      "time_elapsed": timeElapsed,
      "percentage_done_quizzes": percentageDoneQuizzes
    };
  }

}