import 'dart:convert' show jsonDecode;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import 'package:http/http.dart' as http show Response, get;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/utils.dart';


/// Base class for [JWT] and [JWTR]
/// it contains the key and the methods to [read], [write] and [delete] the [token]
/// all methods are [async]
abstract class JWTBase {
  final _storage = const FlutterSecureStorage();

  // key for the token
  String get key;
  String get verboseName;

  /// Write the token to the device
  /// [value] is the token to be written
  Future<void> write(String value) async {
    printOrder('writing $verboseName : $value');
    await _storage.write(key: key, value: value);
  }

  /// Read the token from the device
  /// returns the token as a [String]
  /// if the token is not found it will write an empty string to the device
  /// and return an empty string
  Future<String> read() async {
    String? value = await _storage.read(key: key);
    if (value == null) {
      await _storage.write(key: key, value: '');
      value = '';
    }
    return value;
  }

  /// Delete the token from the device
  Future<void> delete() async {
    await _storage.delete(key: key);
  }
}


/// JWT class to handle the JWT token
class JWT extends JWTBase {
  @override
  String get key => 'jwt';

  @override
  String get verboseName => 'JWT';

  /// Check if the token is empty
  /// returns a [bool]
  Future<bool> get isLogged async {
    final String token = await read();
    return token.isNotEmpty;
  }

  Future<void> refresh() async {
    final JWTR jwtr = JWTR();
    final String refreshToken = await jwtr.read();

    printOrder("refreshing $verboseName");

    // if the refresh token is empty, return
    if (refreshToken.isEmpty) {
      printError("refresh token is empty");
      return;
    }

    // send the refresh token to the server
    final http.Response response = await http.get(
      Uri.parse('$apiUrl/connection/refresh'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': refreshToken,
      }
    );

    // if the response is successful, write the new token to the device
    if (response.ok) {

      printOrder("refresh response ok, writing new $verboseName");

      final dynamic data = jsonDecode(response.body);
      final String token = data["access_token"] ?? "";
      if (token.isNotEmpty) {
        await write(token);
        printSuccess("new $verboseName written");
      }
    } else {
      printError("refresh response not ok");
      printWarning(response.body);
    }
  }
}

/// JWTR class to handle the JWT refresh token
class JWTR extends JWTBase {
  @override
  String get key => 'jwt-refresh';

  @override
  String get verboseName => 'Refresh Token';
}