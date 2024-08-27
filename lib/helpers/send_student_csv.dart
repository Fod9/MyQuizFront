import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
import 'jwt/jwt.dart';
import 'jwt/token_checker.dart';
import '../constants.dart';

Future<List<dynamic>> sendStudentCsv(File file) async {
  final JWT jwt = JWT();

  Future<http.Response> fResponse() async {
    final uri = Uri.parse('$apiUrl/student/import');
    final request = http.MultipartRequest('POST', uri)
      ..headers['authorization'] = await jwt.read()
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  final http.Response response = await checkToken(fResponse);

  if (response.error) {
    printError("sendStudentCsv Error: ${response.body}");
    return [];
  } else {
    final dynamic data = jsonDecode(response.body);
    return data;
  }
}