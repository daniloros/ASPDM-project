// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      admin: json['admin'] as bool?,
      weight: (json['peso'] as num?)?.toDouble(),
      leanMass: (json['massaMagra'] as num?)?.toDouble(),
      bodyFat: (json['massaGrassa'] as num?)?.toDouble(),
      hydro: (json['idratazione'] as num?)?.toDouble(),
      bmr: json['bmr'] as int?,
      name: json['nome'] as String?,
      surname: json['cognome'] as String?,
      birthday: json['dataNascita'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      '_id': instance.id,
      'admin': instance.admin,
      'peso': instance.weight,
      'massaGrassa': instance.bodyFat,
      'massaMagra': instance.leanMass,
      'idratazione': instance.hydro,
      'bmr': instance.bmr,
      'nome': instance.name,
      'cognome': instance.surname,
      'dataNascita': instance.birthday,
    };
