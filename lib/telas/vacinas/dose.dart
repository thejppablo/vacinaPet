import 'package:json_annotation/json_annotation.dart';
part 'dose.g.dart';

@JsonSerializable()
class Dose{
  final String applicationDate;
  final String manufacturingDate;
  final String expirationDate;
  final int order;
  final String dosage, veterinary, petVaccinesId;

  Dose(this.applicationDate,this.manufacturingDate,this.expirationDate,
      this.order,this.dosage,this.veterinary,this.petVaccinesId);

  factory Dose.fromJson(Map<String,dynamic> data) => _$DoseFromJson(data);

  Map<String,dynamic> toJson() => _$DoseToJson(this);
}