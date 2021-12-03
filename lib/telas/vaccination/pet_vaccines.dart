import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dose.dart';

class PetVaccines{

   final String vaccineId;
   final String petId;
   final List<Dose> doses;

  PetVaccines({
    required this.vaccineId,
    required this.petId,
    required this.doses});

   factory PetVaccines.fromJson(Map<String, dynamic> json) => PetVaccines(
     vaccineId: json["vaccineId"],
     petId: json["petId"],
     doses: List<Dose>.from(json["doses"].map((x) => Dose.fromJson(x))),
   );

   Map<String, dynamic> toJson() => {
     "vaccineId": vaccineId,
     "petId": petId,
     "doses": List<dynamic>.from(doses.map((x) => x.toJson())),
   };


}

PetVaccines petVaccinesFromJson(String str) => PetVaccines.fromJson(json.decode(str));

String petVaccinesToJson(PetVaccines data) => json.encode(data.toJson());

Future<bool> postVaccines(PetVaccines vacina, var dose) async{
  //print("ID NAO NULA ${vaccineId}");
  //print("PRINT ${petVaccinesToJson(vacina)}");
  var body = {
    "vaccineId": vacina.vaccineId,
    "petId": vacina.petId,
    "doses": [
      {
        "application_date": "2021-11-26T01:58:20.626Z",
        "manufacturing_date": "2021-11-26T01:58:20.626Z",
        "expiration_date": "2021-11-26T01:58:20.626Z",
        "order": [{}],
        "dosage": "string",
        "veterinary": "string",
        "petVaccinesId": "string"
      }]};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/pet-vaccines');
  var response = await http.post(url,
  headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${prefs.getString('accessToken').toString()}',
  },
  body: json.encode(body)
  );

  if(response.statusCode == 201){
    //print("VACINA REGISTRADA ${response.body}");
    print("vacina registrada com sucesso");
    return true;

  }else{
    print("STATUS CODE: ${response.statusCode}");
    throw Exception('API ERROR ${response.body}');
  }


}
