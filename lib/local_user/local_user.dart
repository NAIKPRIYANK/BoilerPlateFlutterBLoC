import 'dart:convert';
import 'dart:developer';

import 'package:flutterboilerplateblocpattern/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LocalUser {
  late final SharedPreferences _prefs;

  ///  **Store user data in SharedPreferences**
  Future<void> setUser(LocalUserModel user, String token) async {
    try {
      _prefs = await SharedPreferences.getInstance();

      String userJson = jsonEncode(user.toJson());
      await _prefs.setString(
          'user_data', userJson); // Store user object as JSON
      await _prefs.setString('jwt', token.trim()); // Store JWT Token
      // ignore: empty_catches
    } catch (err) {
      log(err.toString());
    }
  }

  ///  **Get user data from SharedPreferences**
  Future<LocalUserModel?> getUser() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      String? userJson = _prefs.getString('user_data');

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        return LocalUserModel.fromJson(userMap);
      }
    } catch (err) {
      log("Error while retrieving user data: $err");
    }
    return null;
  }

  ///  **Store only the JWT Token**
  Future<void> setToken(String token) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await _prefs.setString('jwt', token.trim());
    } catch (err) {
      log("Error while saving token: $err");
    }
  }

  ///  **Retrieve the JWT Token**
  Future<String?> getToken() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      return _prefs.getString('jwt');
    } catch (err) {
      log("Error while retrieving token: $err");
    }
    return null;
  }

  ///  **Check if user is logged in**
  Future<bool> isUserLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.containsKey('user_data');
  }
}
