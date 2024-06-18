import 'dart:convert' show jsonEncode;
import 'package:http/http.dart' as http show Response, post;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart' show checkToken;
import 'package:my_quiz_ap/helpers/utils.dart' show printError;


Future<bool> saveNote(double note, int userId, int quizId, int timeElapsed) async {

  JWT jwt = JWT();

  double parsedNote = note;

  if (note == 0.0) {
    parsedNote = -1.0;
  }

  Future<http.Response> fResponse() async => http.post(
    Uri.parse('$apiUrl/quiz/saveNote/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': await jwt.read(),
    },
    body: jsonEncode(<String, dynamic>{
      'quiz_id': quizId,
      'student_id': userId,
      'note': parsedNote,
      'time_elapsed': timeElapsed,
    }),
  );

  final http.Response response = await checkToken(fResponse);

  if (response.error) {
    printError("saveNote Error: ${response.body}");
    return false;
  } else {
    return true;
  }
}