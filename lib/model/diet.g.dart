// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diet _$DietFromJson(Map<String, dynamic> json) => Diet(
      id: json['_id'] as String?,
      carboGr: json['carboGr'] as int?,
      lipidsGr: json['lipidsGr'] as int?,
      vegetableGr: json['vegetableGr'] as int?,
      lipids: json['lipids'] as String?,
      proteinGr: json['proteinGr'] as int?,
      isCurrent: json['isCurrent'] as bool?,
      protein: json['protein'] as String?,
      vegetable: json['vegetable'] as String?,
      carbo: json['carbo'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$DietToJson(Diet instance) => <String, dynamic>{
      '_id': instance.id,
      'carboGr': instance.carboGr,
      'lipidsGr': instance.lipidsGr,
      'vegetableGr': instance.vegetableGr,
      'lipids': instance.lipids,
      'proteinGr': instance.proteinGr,
      'isCurrent': instance.isCurrent,
      'protein': instance.protein,
      'vegetable': instance.vegetable,
      'carbo': instance.carbo,
      'userId': instance.userId,
    };
