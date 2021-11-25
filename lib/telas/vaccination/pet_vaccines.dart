import 'package:json_annotation/json_annotation.dart';
import 'dose.dart';
part '../../auto_json/pet_vaccines.g.dart';

@JsonSerializable(explicitToJson: true)
class PetVaccines{

  final String vaccineId;
  final String petId;
  final List<Dose> doses;

  PetVaccines(this.vaccineId, this.petId,this.doses);

  factory PetVaccines.fromJson(Map<String,dynamic> data) => _$PetVaccinesFromJson(data);

  Map<String,dynamic> toJson() => _$PetVaccinesToJson(this);

}
/*
Future<bool> postVaccines() async{
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/pet-vaccines');

}
*/