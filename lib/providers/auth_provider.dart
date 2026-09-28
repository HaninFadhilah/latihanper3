import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;
  bool get isAuthenticated => _token != null;

  Future<bool> login(String email, String password) async {
    if (password.length < 6) {
      return false;
    }

    _token = 'demo-token';
    notifyListeners();
    return true;
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}