import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends ChangeNotifier {
  String? username, password;
  @JsonKey(name: '_id', required: false)
  String? id;
  bool? admin;
  @JsonKey(name: 'peso', required: false)
  double? weight;
  @JsonKey(name: 'massaGrassa', required: false)
  double? bodyFat;
  @JsonKey(name: 'massaMagra', required: false)
  double? leanMass;
  @JsonKey(name: 'idratazione', required: false)
  double? hydro;
  int? bmr;

  @JsonKey(name: 'nome', required: false)
  String? name;
  @JsonKey(name: 'cognome', required: false)
  String? surname;
  @JsonKey(name: 'dataNascita', required: false)
  String? birthday;


  User({this.id, this.username, this.password, this.admin, this.weight, this.leanMass, this.bodyFat, this.hydro, this.bmr, this.name, this.surname, this.birthday});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString("login_username");

    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    this.username = username;
    this.password = password;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("login_username", username);

  }

  Future<void> logout() async {
    username = null;
    password = null;

    notifyListeners();
  }


  User copy({
    double? weight,
    double? leanMass,
    double? bodyFat,
    double? hydro,
    int? bmr,
  }) =>
      User(
        id: this.id,
        password: this.password,
        username: this.username,
        name: this.name,
        surname: this.surname,
        birthday: this.birthday,
        admin: this.admin,
        weight: weight ?? this.weight,
        leanMass: leanMass ?? this.leanMass,
        bodyFat: bodyFat ?? this.bodyFat,
        bmr: bmr ?? this.bmr,
        hydro: hydro ?? this.hydro,
      );
}
