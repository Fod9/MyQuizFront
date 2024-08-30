import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT;
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/helpers/utils.dart' show printError, printInfo, printWarning;
import 'package:my_quiz_ap/helpers/http_extensions.dart';


/// This function checks the token and refreshes it if it is expired
/// - [fResponse] is the function that returns the request (type: [Future<http.Response>]).
/// it has to be a function to reset the request each time the token is refreshed
/// - [maxRetries] is the maximum number of retries
/// - [retryCount] is the current number of retries (better not setting it)
/// - returns a [Future<http.Response>]
Future<http.Response> checkToken(
    Future<http.Response> Function() fResponse,
    {
      int maxRetries = 2,
      retryCount = 0,
    }
  ) async {

  if (retryCount > 0) printInfo("check token retry number $retryCount");

  // await the response from a fresh request
  final http.Response response = await fResponse();

  // if the response has error status and contains "Unauthorized"
  if (response.error && response.body.contains("Unauthorized")) {
    // if the limit of retries is reached, return an unauthorized response
    printError("Unauthorized");
    printWarning(response.body);
    if (retryCount >= maxRetries) {
      printError("Maximum retries exceeded");
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
  } else {
    // if the response is successful, return the response
    return response;
  }
}