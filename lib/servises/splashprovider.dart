import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// ignore: constant_identifier_names
const String save_key_name = 'isLoggedIn'; 

class SplashScreenProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    _isLoggedIn = sharedPrefs.getBool(save_key_name) ?? false;
    notifyListeners();
  }

  Future<void> login() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(save_key_name, true);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(save_key_name, false);
    _isLoggedIn = false;
    notifyListeners();
  }
}
