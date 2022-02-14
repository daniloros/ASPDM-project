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

  DateTime _dietLunchLastLoad = DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true);
  DateTime _dietDinnerLastLoad = DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true);

  Future loadDietLunch(String? username, [bool force = false]) async {
    if (_isLoading) return;

    final target = _dietLunchLastLoad.add(const Duration(minutes: 1));

    debugPrint(target.toString());

    if(!force && DateTime.now().toUtc().isBefore(target)){
      debugPrint("Too early, not loading");
      return;
    }

    _isLoading = true;
    notifyListeners();



    try {
      final list = await DietProvider.loadLunchDiet(username!);

      _dietLunchList = list;

      final current = await DietProvider.loadCurrentLunchDiet(username);

      _dietLunchLastLoad = DateTime.now().toUtc();

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
    if (_isLoading) return;

    final target = _dietDinnerLastLoad.add(const Duration(minutes: 1));

    if(!force && DateTime.now().toUtc().isBefore(target)){
      debugPrint("Too early, not loading");
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final list = await DietProvider.loadDinnerDiet(username!);
      _dietDinnerList = list;

      final current = await DietProvider.loadCurrentDinnerDiet(username);

      _dietDinnerLastLoad = DateTime.now().toUtc();
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
