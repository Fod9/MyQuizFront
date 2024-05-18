import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:http/http.dart' as http;
import '../http_extensions.dart';


/// This function checks the token and refreshes it if it is expired
/// [fResponse] is the request to be sent
/// [maxRetries] is the maximum number of retries
/// [retryCount] is the current number of retries (better not setting it)
/// returns a [Future<http.Response>]
Future<http.Response> checkToken(
    Future<http.Response> fResponse,
    {
      int maxRetries = 2,
      retryCount = 2,
    }
  ) async {

  // await the response from the request
  final http.Response response = await fResponse;

  // if the response has error status and contains "Unauthorized"
  if (response.error && response.body.contains("Unauthorized")) {
    // if the limit of retries is reached, return an unauthorized response
    if (retryCount >= maxRetries) {
      return Future.value(http.Response("Unauthorized request, maximum retries exceeded", 401));

    // if the limit of retries is not reached, refresh the token and retry the request
    } else {

      // refresh the token
      final JWT jwt = JWT();
      await jwt.refresh();

      // retry the request with recursive call
      return await checkToken(
          fResponse,
          retryCount: retryCount + 1, // increment the retry count
          maxRetries: maxRetries
      );
    }
  }

  return await fResponse;
}