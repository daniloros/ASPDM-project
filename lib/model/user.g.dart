// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String?,
      password: json['password'] as String?,
      admin: json['admin'] as bool?,
      weight: (json['peso'] as num?)?.toDouble(),
      leanMass: (json['massaMagra'] as num?)?.toDouble(),
      bodyFat: (json['massaGrassa'] as num?)?.toDouble(),
      hydro: (json['idratazione'] as num?)?.toDouble(),
      bmr: json['bmr'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'admin': instance.admin,
      'peso': instance.weight,
      'massaGrassa': instance.bodyFat,
      'massaMagra': instance.leanMass,
      'idratazione': instance.hydro,
      'bmr': instance.bmr,
    };
