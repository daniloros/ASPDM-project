import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:healty/model/diet_dinner.dart';
import 'package:healty/model/diet_lunch.dart';
import 'package:healty/providers/diet_provider.dart';

class DietPageController extends ChangeNotifier {
  List<DietLunch> _dietLunchList = [];

  int get countLunch => _dietLunchList.length;

  List<DietDinner> _dietDinnerList = [];

  int get countDinner => _dietDinnerList.length;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UnmodifiableListView<DietLunch> get dietLunchList =>
      UnmodifiableListView(_dietLunchList);

  UnmodifiableListView<DietDinner> get dietDinnerList =>
      UnmodifiableListView(_dietDinnerList);

  DietLunch? _currentLunchDiet;

  DietDinner? _currentDinnerDiet;

  DietDinner? get currentDinnerDiet => _currentDinnerDiet;

  DietLunch? get currentLunchDiet => _currentLunchDiet;

  Future loadDietLunch(String? username, [bool force = false]) async {
    debugPrint("IsLoadingLunch ${_isLoading.toString()}");
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final list = await DietProvider.loadLunchDiet(username!);
      _dietLunchList = list;

      final current = await DietProvider.loadCurrentLunchDiet(username);
      if (current.id != "") {
        _currentLunchDiet = current;
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
