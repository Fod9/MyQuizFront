import 'package:http/http.dart' as http show Response;

/// This extension provides a set of methods to check the status code of a http.Response
/// It is used to check if the response is successful, an error, a server error, a redirect or an informational response

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

extension IsError on http.Response {
  bool get error {
    return (statusCode ~/ 100) == 4;
  }
}

extension IsServerError on http.Response {
  bool get serverError {
    return (statusCode ~/ 100) == 5;
  }
}

extension IsRedirect on http.Response {
  bool get redirect {
    return (statusCode ~/ 100) == 3;
  }
}

extension IsInformational on http.Response {
  bool get informational {
    return (statusCode ~/ 100) == 1;
  }
}