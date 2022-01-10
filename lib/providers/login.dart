import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:healty/model/user.dart';
import 'package:http/http.dart' as http;

class Login {
  static Future<int> login(String uid, String password) async {
    debugPrint("Doing Login");

    final response = await http.get(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti?q={"username" : "$uid"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    if (response.statusCode == 200) {
      List<dynamic> responseJson = jsonDecode(response.body);
      final currentUser = responseJson
          .cast<Map<String, dynamic>>()
          .map((e) => User.fromJson(e))
          .toList();
      if (currentUser.isEmpty) {
        return 1;
      } else {
        if (currentUser[0].password != password) {
          return 2;
        } else {
          return 0;
        }
      }
    } else {
      return response.statusCode;
    }
  }

  static Future<User> loadUser(String username) async {
    debugPrint("Loading current lunch diet");

    final response = await http.get(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti?q={"username": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");
    debugPrint("jsonDecode is ${jsonDecode(response.body)[0]}");

    if (response.statusCode == 200) {
      // var jsonResponse = jsonDecode(response.body);

      return User.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception("Errore di comunicazione");
    }
  }
}
