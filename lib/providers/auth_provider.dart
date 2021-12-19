import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_test/models/user.dart';

class AuthProvider extends ChangeNotifier{
  bool _isLoggedIn = false;
  late User _user;

  bool get isLoggedIn => _isLoggedIn;
  User get user => _user;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  set user(User value) {
    _user = value;
    notifyListeners();
  }
}