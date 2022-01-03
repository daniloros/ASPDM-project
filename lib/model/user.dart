import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  String? username, password;
  bool? admin;

  User({this.username, this.password, this.admin});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        admin = json['admin'];

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString("login_username");

    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    this.username = username;
    this.password = password;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("login_username", username);

  }

  Future<void> logout() async {
    username = null;
    password = null;

    notifyListeners();
  }
}
