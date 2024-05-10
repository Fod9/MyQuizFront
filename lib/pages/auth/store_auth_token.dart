import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Class to manage the JWT token
/// It uses the FlutterSecureStorage package
/// Can't be instantiated as it is an abstract class
/// All methods are static and async
abstract class AuthToken {

  // private secure storage instance
  static const _storage = FlutterSecureStorage();

  /// Writes the token to the device
  /// Takes a [String] value as parameter
  /// Returns a [Future<void>]
  static Future<void> write(String value) async {
    await _storage.write(key: 'jwt', value: value);
  }

  /// Reads the token from the device
  /// Returns a [Future<String>]
  static Future<String> read() async {
    String? value = await _storage.read(key: 'jwt');
    if (value == null) {
      await _storage.write(key: 'jwt', value: '');
      value = '';
    }
    return value;
  }

  /// Deletes the token from the device
  static Future<void> delete() async {
    await _storage.delete(key: 'jwt');
  }
}