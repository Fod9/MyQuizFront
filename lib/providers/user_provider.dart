import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String? _userRole;

  String? get userRole => _userRole;

  set userRole(String? role) {
    _userRole = role;
    notifyListeners();
  }
}