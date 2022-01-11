import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';

import 'package:http/http.dart' as http;

class AdminProvider {

  static Future<List<User>> loadUserList() async {
    debugPrint("Loading lunch diet list");

    final response = await http.get(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti?q={"admin": false}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> userResponse = jsonDecode(response.body);
      final userItemData = userResponse
          .cast<Map<String, dynamic>>()
          .map((e) => User.fromJson(e))
          .toList();
      return userItemData;
    } else {
      throw Exception("Errore di comunicazione");
    }
  }
}