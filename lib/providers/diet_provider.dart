import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healty/model/diet_lunch.dart';
import 'package:http/http.dart' as http;

class DietLunchProvider {
  List<DietLunch> _dietLunchList = [];

  List<DietLunch> get dietLunchList => _dietLunchList;

  static Future<List<DietLunch>> loadDiet() async {
    debugPrint("Loading photos");

    final response = await http.get(
        Uri.parse('https://dietflutterapp-685c.restdb.io/rest/dietLunch'),
        headers: {
          "Content-Type": "application/json",
          "x-apikey": "6c2d6f4ac1a8d9943d70ee4a2ac0be41d7041",
        });

    debugPrint("GET result ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> photosData = jsonDecode(response.body);
      final photoItemData = photosData
          .cast<Map<String, dynamic>>()
          .map((e) => DietLunch.fromJson(e))
          .toList();
      return photoItemData;
    } else {
      throw Exception("Errore di comunicazione");
    }
  }
}
