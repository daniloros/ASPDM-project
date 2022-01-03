import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diet_lunch.g.dart';

@JsonSerializable()
class DietLunch extends Equatable {
  @JsonKey(name: '_id', required: false)
  String id;
  String userId;
  String carbo;
  int carboGr;
  String protein;
  int? proteinGr;
  String lipids;
  int lipidsGr;
  String vegetable;
  int vegetableGr;
  bool isCurrent;

  DietLunch(
      this.id,
      this.userId,
      this.carbo,
      this.carboGr,
      this.protein,
      this.proteinGr,
      this.lipids,
      this.lipidsGr,
      this.vegetable,
      this.vegetableGr,
      this.isCurrent
      );

  @override
  List<Object?> get props => [id];

  factory DietLunch.fromJson(Map<String, dynamic> json) => _$DietLunchFromJson(json);
  Map<String, dynamic> toJson() => _$DietLunchToJson(this);
}
