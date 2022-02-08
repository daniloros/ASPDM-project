import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healty/model/diet.dart';
import 'package:http/http.dart' as http;

class DietProvider {
  List<Diet> _dietLunchList = [];

  List<Diet> get dietLunchList => _dietLunchList;

  List<Diet> _dietDinnerList = [];

  List<Diet> get dietDinnerList => _dietDinnerList;


  static Future<List<Diet>> loadLunchDiet(String username) async {
    debugPrint("Loading lunch diet list");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietlunch?q={"isCurrent":false, "userId": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> lunchResponse = jsonDecode(response.body);
      final lunchItemData = lunchResponse
          .cast<Map<String, dynamic>>()
          .map((e) => Diet.fromJson(e))
          .toList();
      return lunchItemData;
    } else {
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<List<Diet>> loadDinnerDiet(String username) async {
    debugPrint("Loading dinner list diet");
    debugPrint(username);

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietdinner?q={"isCurrent":false, "userId": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> dinnerResponse = jsonDecode(response.body);
      final dinnerItemData = dinnerResponse
          .cast<Map<String, dynamic>>()
          .map((e) => Diet.fromJson(e))
          .toList();
      return dinnerItemData;
    } else {
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<Diet> loadCurrentLunchDiet(String username) async {
    debugPrint("Loading current lunch diet");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietlunch?q={"isCurrent":true, "userId": "$username"}'),
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
        return Diet(id: "", carbo: "", carboGr: 0, isCurrent: false, lipids: "", lipidsGr: 0, protein: "", proteinGr: 0, userId: "", vegetable: "", vegetableGr: 0);
        //return Diet("", "", "", 0, "", 0, "", 0, "", 0, false);
      } else {
        return Diet.fromJson(jsonDecode(response.body)[0]);
      }
    } else {
      throw Exception("Errore di comunicazione");
    }
  }

  static Future<Diet> loadCurrentDinnerDiet(String username) async {
    debugPrint("Loading current dinner diet");

    final response = await http.get(
          Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietdinner?q={"isCurrent":true, "userId": "$username"}'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");
    debugPrint("response: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse.isEmpty){
        return Diet(id: "", carbo: "", carboGr: 0, isCurrent: false, lipids: "", lipidsGr: 0, protein: "", proteinGr: 0, userId: "", vegetable: "", vegetableGr: 0);
        // return Diet("", "", "", 0, "", 0, "", 0, "", 0, false);
      } else {
        return Diet.fromJson(jsonDecode(response.body)[0]);
      }
    }  else {
      throw Exception("Errore di comunicazione");
    }
  }

}
