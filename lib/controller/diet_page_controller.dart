import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:healty/model/diet_lunch.dart';
import 'package:healty/providers/diet_provider.dart';


class DietPageController extends ChangeNotifier{
  List<DietLunch> _dietLunchList = [];

  int get count => _dietLunchList.length;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UnmodifiableListView<DietLunch> get dietLunchList => UnmodifiableListView(_dietLunchList);

  Future loadDietLunch([bool force = false]) async {

    if(_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final list = await DietLunchProvider.loadDiet();
      _dietLunchList = list;

    } finally {
      _isLoading = false;
    }
    notifyListeners();


  }

}