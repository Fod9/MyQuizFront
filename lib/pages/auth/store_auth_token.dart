import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthToken {
  static const storage = FlutterSecureStorage();

  static Future<void> write(String value) async {
    await storage.write(key: 'jwt', value: value);
  }

  static Future<String> read() async {
    String? value = await storage.read(key: 'jwt');
    if (value == null) {
      await storage.write(key: 'jwt', value: '');
      value = '';
    }
    return value;
  }

  static Future<void> delete() async {
    await storage.delete(key: 'jwt');
  }
}