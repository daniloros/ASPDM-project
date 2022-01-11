import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';
import 'package:healty/providers/login.dart';

class LoginController extends ChangeNotifier{


  User? _currentUser;

  User? get currentUser => _currentUser;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future loadCurrentUser(String? username) async {

    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final user = await Login.loadUser(username!);
      _currentUser = user;

    } finally {
      _isLoading = false;
    }

    notifyListeners();

  }
}