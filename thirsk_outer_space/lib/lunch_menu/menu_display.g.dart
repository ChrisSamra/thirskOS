// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_display.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneDayMenu _$OneDayMenuFromJson(Map<String, dynamic> json) {
  return OneDayMenu(
      menuID: json['menuID'] as String,
      soup: json['soup'] as String,
      soupCost: json['soupCost'] as String,
      entree: json['entree'] as String,
      entreeCost: json['entreeCost'] as String,
      starch: json['starch1'] as String,
      starchCost: json['starch1Cost'] as String,
      veggie: json['starch2'] as String,
      veggieCost: json['starch2Cost'] as String,
      dessert: json['dessert'] as String,
      dessertCost: json['dessertCost'] as String,
      menuDate: json['menuDate'] as String);
}

Map<String, dynamic> _$OneDayMenuToJson(OneDayMenu instance) =>
    <String, dynamic>{
      'menuID': instance.menuID,
      'soup': instance.soup,
      'soupCost': instance.soupCost,
      'entree': instance.entree,
      'entreeCost': instance.entreeCost,
      'starch1': instance.starch,
      'starch1Cost': instance.starchCost,
      'starch2': instance.veggie,
      'starch2Cost': instance.veggieCost,
      'dessert': instance.dessert,
      'dessertCost': instance.dessertCost,
      'menuDate': instance.menuDate
    };
