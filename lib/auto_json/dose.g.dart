// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../telas/vaccination/dose.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dose _$DoseFromJson(Map<String, dynamic> json) => Dose(
      json['applicationDate'] as String,
      json['manufacturingDate'] as String,
      json['expirationDate'] as String,
      json['order'] as int,
      json['dosage'] as String,
      json['veterinary'] as String,
      json['petVaccinesId'] as String,
    );

Map<String, dynamic> _$DoseToJson(Dose instance) => <String, dynamic>{
      'applicationDate': instance.applicationDate,
      'manufacturingDate': instance.manufacturingDate,
      'expirationDate': instance.expirationDate,
      'order': instance.order,
      'dosage': instance.dosage,
      'veterinary': instance.veterinary,
      'petVaccinesId': instance.petVaccinesId,
    };
