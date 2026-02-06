import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;

  final String mockOtp = "123456";

  bool verifyOtp(String otp) {
    if (otp == mockOtp) {
      Hive.box('auth').put('loggedIn', true);
      isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }
}
