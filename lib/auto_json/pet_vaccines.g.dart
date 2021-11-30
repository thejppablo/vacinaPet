// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../telas/vaccination/pet_vaccines.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetVaccines _$PetVaccinesFromJson(Map<String, dynamic> json) => PetVaccines(
      json['vaccineId'] as String,
      json['petId'] as String,
      (json['doses'] as List<dynamic>)
          .map((e) => Dose.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PetVaccinesToJson(PetVaccines instance) =>
    <String, dynamic>{
      'vaccineId': instance.vaccineId,
      'petId': instance.petId,
      'doses': instance.doses.map((e) => e.toJson()).toList(),
    };
