import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:healty/model/diet_dinner.dart';
import 'package:healty/model/diet_lunch.dart';
import 'package:healty/providers/diet_provider.dart';


class DietPageController extends ChangeNotifier{

  List<DietLunch> _dietLunchList = [];

  int get countLunch => _dietLunchList.length;

  List<DietDinner> _dietDinnerList = [];

  int get countDinner => _dietDinnerList.length;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UnmodifiableListView<DietLunch> get dietLunchList => UnmodifiableListView(_dietLunchList);
  UnmodifiableListView<DietDinner> get dietDinnerList => UnmodifiableListView(_dietDinnerList);

  Future loadDietLunch([bool force = false]) async {

    if(_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final list = await DietProvider.loadLunchDiet();
      _dietLunchList = list;

    } finally {
      _isLoading = false;
    }
    notifyListeners();


  }

  Future loadDietDinner([bool force = false]) async {

    if(_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final list = await DietProvider.loadDinnerDiet();
      _dietDinnerList = list;

    } finally {
      _isLoading = false;
    }
    notifyListeners();


  }

}