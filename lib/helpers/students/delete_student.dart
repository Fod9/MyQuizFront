import 'dart:convert';

import 'package:http/http.dart' as http show Response, post;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart' show checkToken;

/// This function deletes a student from the database
/// it takes the student email as a parameter to find the student
/// and delete it
/// it returns a boolean value, true if the student was deleted
/// and error message if an error occurred
Future<bool> deleteStudent(String studentEmail) async {

  // create a JWT instance
  final JWT jwt = JWT();

  // request to get the quiz using the id
  Future<http.Response> fResponse() async => http.post(
    Uri.parse('$apiUrl/student/delete/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': await jwt.read(),
    },
    body: jsonEncode(<String, String>{
      'email': studentEmail,
    }),
  );

  // check the token and get the response
  final http.Response response = await checkToken(fResponse);

  // if the response is an error, return the error message
  if (response.error && response.body.contains("Unauthorized")) {
    return Future.value(false);
  } else if (response.ok) {  // if the response is ok, return the data
    return Future.value(true);
  } else {  // if an error occurred, return an error message
    return Future.value(false);
  }
}