import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healty/model/diet.dart';
import 'package:healty/model/user.dart';

import 'package:http/http.dart' as http;

class AdminProvider {

  static Future<List<User>> loadUserList() async {
    debugPrint("Loading user list");

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

  static Future<User> loadUserDetails(String? username) async {
    debugPrint("Loading user details ");

    final response = await http.get(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti?q={"_id": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception("Errore di comunicazione");
    }
  }


  static Future<bool> updateUser(User user) async {
    debugPrint("Loading lunch diet list");

    final response = await http.put(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti/${user.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
        body: json.encode(user.toJson())
        );

    var jsonTest = json.encode(user.toJson());

    debugPrint(jsonTest);

    debugPrint("PUT result ${response.statusCode}");

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<bool> archiveLunchDiet(String userId) async {
    debugPrint("update lunch diet for archive");

    debugPrint(userId);



    final response = await http.patch(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietlunch/$userId'),
        headers: {
          'Content-Type': 'application/json',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
        body: jsonEncode(<String, dynamic>{
          'isCurrent' : false
        })
    );

    debugPrint("PATCH result ${response.statusCode}");

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception("Errore di comunicazione");
    }
  }


  static Future<bool> addNewLunchDiet(Diet newDiet) async {
    debugPrint("Loading lunch diet list");

    final response = await http.post(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/dietlunch'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
        body: json.encode(newDiet.toJson())
    );

    var jsonTest = json.encode(newDiet.toJson());

    debugPrint(jsonTest);

    debugPrint("POST result ${response.statusCode}");

    if (response.statusCode == 201) {
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<bool> archiveDinnerDiet(String userId) async {
    debugPrint("update lunch diet for archive");

    debugPrint(userId);



    final response = await http.patch(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietdinner/$userId'),
        headers: {
          'Content-Type': 'application/json',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
        body: jsonEncode(<String, dynamic>{
          'isCurrent' : false
        })
    );

    debugPrint("PATCH result ${response.statusCode}");

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception("Errore di comunicazione");
    }
  }


  static Future<bool> addNewDinnerDiet(Diet newDiet) async {
    debugPrint("Loading lunch diet list");

    final response = await http.post(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/dietdinner'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
        body: json.encode(newDiet.toJson())
    );

    var jsonTest = json.encode(newDiet.toJson());

    debugPrint(jsonTest);

    debugPrint("POST result ${response.statusCode}");

    if (response.statusCode == 201) {
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<bool> deleteUser(String idUsername) async {
    debugPrint("Loading lunch diet list");

    final response = await http.delete(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti/$idUsername'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<bool> addNewUser(User newUser) async {
    debugPrint("try to create new user");

    final response = await http.post(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
        body: json.encode(newUser.toJson())
    );

    var jsonTest = json.encode(newUser.toJson());

    debugPrint(jsonTest);

    debugPrint("POST result ${response.statusCode}");

    if (response.statusCode == 201) {
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<bool> checkUserExist(String username) async{
    debugPrint("check if user exists");
    final response = await http.get(
        Uri.parse(
            'https://dietflutterapp-685c.restdb.io/rest/utenti?q={"username" : "$username"}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        },
    );

    var jsonResponse = jsonDecode(response.body);
    debugPrint("jsonResponse ${jsonResponse.length}");
    debugPrint("isEmpty ${jsonResponse.isEmpty}");
    if(response.statusCode == 200){
      if(jsonResponse.isEmpty){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

}