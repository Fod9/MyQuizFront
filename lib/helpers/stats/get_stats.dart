import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/helpers/http_extensions.dart';

import '../../constants.dart';
import '../jwt/jwt.dart';
import '../jwt/token_checker.dart';
import '../utils.dart';

Future<Map> getStats() async {
  JWT jwt = JWT();
  num average_note = 0;
  num time_elapsed = 0;
  num percentage_done_quizzes = 0;

  try {
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
      average_note = data["averageNote"];
      time_elapsed = data["timeElapsed"];
      percentage_done_quizzes = data["percentageOfDoneQuizzes"];
      return {
        "average_note": average_note,
        "time_elapsed": time_elapsed,
        "percentage_done_quizzes": percentage_done_quizzes
      };
    }
  }catch (error){
    return {
      "error": "An error occurred, please try again later"
    };
  }
}