import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http show Response, get;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart' show checkToken;


Future<List<dynamic>> getStudentList() async {

  // create a JWT instance
  final JWT jwt = JWT();

  // request to get the quiz using the id
  Future<http.Response> fResponse() async => http.get(
    Uri.parse('$apiUrl/student/list/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': await jwt.read(),
    },
  );

  // check the token and get the response
  final http.Response response = await checkToken(fResponse);

  // if the response is an error, return the error message
  if (response.error && response.body.contains("Unauthorized")) {
    return Future.error("Unauthorized");
  } else if (response.ok) {  // if the response is ok, return the data
    dynamic data = jsonDecode(response.body);
    return Future.value(data);
  } else {  // if an error occurred, return an error message
    return Future.error("An error occurred");
  }
}