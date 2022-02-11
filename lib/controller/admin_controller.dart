import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';
import 'package:healty/providers/admin_provider.dart';

class AdminController  extends ChangeNotifier{

  List<User> _userList = [];

  UnmodifiableListView<User> get userList =>
      UnmodifiableListView(_userList);

  int get countUsers => _userList.length;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  User? _userDetails;

  User? get userDetails => _userDetails;

  Future loadUserList() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final list = await AdminProvider.loadUserList();
      _userList = list;

    } finally {
      _isLoading = false;
    }

    notifyListeners();
  }

  Future loadUserDetails(String? username) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final details = await AdminProvider.loadUserDetails(username);
      _userDetails = details;

    } finally {
      _isLoading = false;
    }

    notifyListeners();
  }



}