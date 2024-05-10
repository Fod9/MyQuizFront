import 'package:http/http.dart' as http show Response;

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