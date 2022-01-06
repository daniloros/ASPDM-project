import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healty/model/diet_dinner.dart';
import 'package:healty/model/diet_lunch.dart';
import 'package:http/http.dart' as http;

class DietProvider {
  List<DietLunch> _dietLunchList = [];

  List<DietLunch> get dietLunchList => _dietLunchList;

  List<DietLunch> _dietDinnerList = [];

  List<DietLunch> get dietDinnerList => _dietDinnerList;

  static Future<List<DietLunch>> loadLunchDiet(String username) async {
    debugPrint("Loading lunch diet list");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietLunch?q={"isCurrent":false, "userId": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> lunchResponse = jsonDecode(response.body);
      final lunchItemData = lunchResponse
          .cast<Map<String, dynamic>>()
          .map((e) => DietLunch.fromJson(e))
          .toList();
      return lunchItemData;
    } else {
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<List<DietDinner>> loadDinnerDiet(String username) async {
    debugPrint("Loading dinner list diet");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietDinnerq={"isCurrent":false, "userId": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> dinnerResponse = jsonDecode(response.body);
      final dinnerItemData = dinnerResponse
          .cast<Map<String, dynamic>>()
          .map((e) => DietDinner.fromJson(e))
          .toList();
      return dinnerItemData;
    } else {
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<DietLunch> loadCurrentLunchDiet(String username) async {
    debugPrint("Loading current lunch diet");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietLunch?q={"isCurrent":true, "userId": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      debugPrint("jsonResponse ${jsonResponse.length}");
      if(jsonResponse.isEmpty){
        debugPrint("jsonResponse is empty");
        return DietLunch("", "", "", 0, "", 0, "", 0, "", 0, false);
      } else {
        return DietLunch.fromJson(jsonDecode(response.body)[0]);
      }
    } else {
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<DietDinner> loadCurrentDinnerDiet(String username) async {
    debugPrint("Loading current dinner diet");

    final response = await http.get(
          Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietDinner?q={"isCurrent":true, "userId": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");
    debugPrint("response: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse.isEmpty){
        return DietDinner("", "", "", 0, "", 0, "", 0, "", 0, false);
      } else {
        return DietDinner.fromJson(jsonDecode(response.body)[0]);
      }
    }  else {
      throw Exception("Errore di comunicazione");
    }
  }

}
