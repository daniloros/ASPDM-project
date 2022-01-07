import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diet.g.dart';

@JsonSerializable()
class Diet extends Equatable {
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

  Diet(
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

  factory Diet.fromJson(Map<String, dynamic> json) => _$DietFromJson(json);
  Map<String, dynamic> toJson() => _$DietToJson(this);

}
