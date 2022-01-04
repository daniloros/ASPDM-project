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

  static Future<List<DietLunch>> loadLunchDiet() async {
    debugPrint("Loading photos");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietLunch'),
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

  static Future<List<DietDinner>> loadDinnerDiet() async {
    debugPrint("Loading photos");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietdinner'),
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
}
