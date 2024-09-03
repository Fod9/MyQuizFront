import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
import '../jwt/jwt.dart';
import '../jwt/token_checker.dart';
import '../../constants.dart';


Future<int> generateQuizPdf({
  required File file,
  required String matiere,
  required String name,
  required int userId,
  required List<int> classes,
}) async {
  final JWT jwt = JWT();

  Future<http.Response> fResponse() async {
    final uri = Uri.parse('$apiUrl/quiz/createFromPDF');
    final request = http.MultipartRequest('POST', uri)
      ..headers['authorization'] = await jwt.read()
      ..files.add(await http.MultipartFile.fromPath('file', file.path))
      ..fields['matiere'] = matiere
      ..fields['name'] = name
      ..fields['created_by'] = userId.toString()
      ..fields['created_at'] = DateTime.now().toIso8601String().substring(0, 10);

    for (final class_ in classes) {
      request.fields['classes'] = class_.toString();
    }

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  final http.Response response = await checkToken(fResponse);

  if (response.error) {
    printError("generateQuizPdf Error: ${response.body}");
    return -1;
  } else {
    printInfo("sendStudentCsv: ${response.body}");
    final dynamic data = jsonDecode(response.body);
    return data['quiz_id'];
  }
}