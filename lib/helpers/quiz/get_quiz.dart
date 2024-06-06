

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http show Response, get;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart' show checkToken;
import 'package:my_quiz_ap/helpers/utils.dart';

Future<Map<String, dynamic>> getQuiz(int id) async {

  final JWT jwt = JWT();

  // request to get the list of quiz
  Future<http.Response> fResponse() async => http.get(
    Uri.parse('$apiUrl/quiz/getQuizById/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': await jwt.read(),
    },
  );

  // check the token and get the response
  final http.Response response = await checkToken(fResponse);

  if (response.error && response.body.contains("Unauthorized")) {
    return Future.value({"error": "Unauthorized request, please login again"});
  } else if (response.ok) {
    dynamic data = jsonDecode(response.body);
    printInfo(data["Questions"].toString());
    return Future.value(data);
  } else {
    return Future.value({"error": "An error occurred, please try again later"});
  }
}