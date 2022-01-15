import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:healty/model/diet.dart';
import 'package:healty/providers/diet_provider.dart';

class DietPageController extends ChangeNotifier {
  List<Diet> _dietLunchList = [];

  int get countLunch => _dietLunchList.length;

  List<Diet> _dietDinnerList = [];

  int get countDinner => _dietDinnerList.length;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UnmodifiableListView<Diet> get dietLunchList =>
      UnmodifiableListView(_dietLunchList);

  UnmodifiableListView<Diet> get dietDinnerList =>
      UnmodifiableListView(_dietDinnerList);

  Diet? _currentLunchDiet;

  Diet? _currentDinnerDiet;

  Diet? get currentDinnerDiet => _currentDinnerDiet;

  Diet? get currentLunchDiet => _currentLunchDiet;

  Future loadDietLunch(String? username, [bool force = false]) async {
    debugPrint("IsLoadingLunch ${_isLoading.toString()}");
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final list = await DietProvider.loadLunchDiet(username!);

      _dietLunchList = list;

      final current = await DietProvider.loadCurrentLunchDiet(username);

      debugPrint("currentToString");
      debugPrint(current.toString());


      
      if (current.id != "") {
        _currentLunchDiet = current;

      } else {
        _currentLunchDiet = null;
      }
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future loadDietDinner(String? username, [bool force = false]) async {
    debugPrint("IsLoadingDinner ${_isLoading.toString()}");
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final list = await DietProvider.loadDinnerDiet(username!);
      _dietDinnerList = list;

      final current = await DietProvider.loadCurrentDinnerDiet(username);
      if (current.id != "") {
        _currentDinnerDiet = current;
      } else {
        _currentDinnerDiet = null;
      }

    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _dietLunchList = [];
    _dietDinnerList = [];
    _currentLunchDiet = null;
    _currentDinnerDiet = null;

    notifyListeners();
  }
}
