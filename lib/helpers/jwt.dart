import 'package:flutter_secure_storage/flutter_secure_storage.dart';


/// Base class for [JWT] and [JWTR]
/// it contains the key and the methods to [read], [write] and [delete] the [token]
/// all methods are [async]
abstract class JWTBase {
  final _storage = const FlutterSecureStorage();

  // key for the token
  String get key;

  /// Write the token to the device
  /// [value] is the token to be written
  Future<void> write(String value) async {
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
}

/// JWTR class to handle the JWT refresh token
class JWTR extends JWTBase {
  @override
  String get key => 'jwt-refresh';
}