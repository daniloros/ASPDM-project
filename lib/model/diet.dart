import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diet.g.dart';

@JsonSerializable()
class Diet extends Equatable {
  @JsonKey(name: '_id', required: false)
  String? id;
  int? carboGr;
  int? lipidsGr;
  int? vegetableGr;
  String? lipids;
  int? proteinGr;
  bool? isCurrent;
  String? protein;
  String? vegetable;
  String? carbo;
  String? userId;


  Diet({
      this.id,
      this.carboGr,
      this.lipidsGr,
      this.vegetableGr,
      this.lipids,
      this.proteinGr,
      this.isCurrent,
      this.protein,
      this.vegetable,
      this.carbo,
      this.userId});

  @override
  List<Object?> get props => [id];

  factory Diet.fromJson(Map<String, dynamic> json) => _$DietFromJson(json);
  Map<String, dynamic> toJson() => _$DietToJson(this);



}
