import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart' show checkToken;
import 'package:my_quiz_ap/helpers/quiz/quiz_list_format.dart' show quizListFormat;
import 'package:my_quiz_ap/helpers/utils.dart' show printError, printInfo;
import 'package:my_quiz_ap/constants.dart' show apiUrl;

/// Get the list of quiz
/// returns a [Future<List<Map<String, dynamic>>]
/// the list contains the name of the bloc and the list of quiz
Future<List<Map<String, dynamic>>> getQuizList() async {

  // get the jwt token
  final JWT jwt = JWT();
  final String token = await jwt.read();

  // request to get the list of quiz
  final Future<http.Response> fResponse = http.get(
    Uri.parse('$apiUrl/quiz/list'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token,
    },
  );

  // check the token and get the response
  final http.Response response = await checkToken(fResponse);

  // if the response has error status and contains "Unauthorized"
  if (response.error && response.body.contains("Unauthorized")) {
    // return an unauthorized response
    return Future.value([{"error": "Unauthorized request, please login again"}]);
  } else if (response.ok) {
    // if the response is successful, decode the data
    final data = jsonDecode(response.body);
    printInfo(data.toString());

    // format the data
    final List<Map<String, dynamic>> formattedQuizList = quizListFormat(data);
    printInfo(formattedQuizList.toString());

    return formattedQuizList;
  } else {
    // if the response has another status code
    printError("${response.statusCode} - ${response.body}");
    // return an error response
    return Future.value([{"error": "An error occurred, please try again later"}]);
  }
}