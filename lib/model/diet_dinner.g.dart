// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_dinner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DietDinner _$DietDinnerFromJson(Map<String, dynamic> json) => DietDinner(
      json['_id'] as String,
      json['userId'] as String,
      json['carbo'] as String,
      json['carboGr'] as int,
      json['protein'] as String,
      json['proteinGr'] as int?,
      json['lipids'] as String,
      json['lipidsGr'] as int,
      json['vegetable'] as String,
      json['vegetableGr'] as int,
      json['isCurrent'] as bool,
    );

Map<String, dynamic> _$DietDinnerToJson(DietDinner instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'carbo': instance.carbo,
      'carboGr': instance.carboGr,
      'protein': instance.protein,
      'proteinGr': instance.proteinGr,
      'lipids': instance.lipids,
      'lipidsGr': instance.lipidsGr,
      'vegetable': instance.vegetable,
      'vegetableGr': instance.vegetableGr,
      'isCurrent': instance.isCurrent,
    };
