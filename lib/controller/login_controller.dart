import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';
import 'package:healty/providers/login.dart';

class LoginController extends ChangeNotifier{


  User? _currentUser;


  User? get currentUser => _currentUser;

  Future loadCurrentUser(String? username) async {

    try {
      final user = await Login.loadUser(username!);
      _currentUser = user;

    } finally {
    }

    notifyListeners();

  }
}