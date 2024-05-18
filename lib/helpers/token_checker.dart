import 'http_extensions.dart';
import 'package:http/http.dart' as http;


Future<http.Response> checkToken(
    Future<http.Response> fResponse,
    {
      int maxRetries = 2,
      retryCount = 2,
    }) async {

  final http.Response response = await fResponse;

  if (response.error && response.body.contains("Unauthorized")) {
    if (retryCount >= maxRetries) {
      return Future.value(http.Response("Unauthorized request, maximum retries exceeded", 401));
    } else {
      return await checkToken(
          fResponse,
          retryCount: retryCount + 1,
          maxRetries: maxRetries
      );
    }
  }

  return await fResponse;
}