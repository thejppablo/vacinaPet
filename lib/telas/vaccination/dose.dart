import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class Dose{
   String? applicationDate;
   String? manufacturingDate;
   String? expirationDate;
   String? dosage,
          veterinary,
          petVaccinesId;

  Dose({required this.applicationDate,
    required this.manufacturingDate,
    required this.expirationDate,
    required this.dosage,
    required this.veterinary,
    required this.petVaccinesId});

  factory Dose.fromJson(Map<String, dynamic> json) => Dose(
    applicationDate: json["application_date"],
    manufacturingDate: json["manufacturing_date"],
    expirationDate: json["expiration_date"],
    dosage: json["dosage"],
    veterinary: json["veterinary"],
    petVaccinesId: json["petVaccinesId"],
  );

   Map<String, dynamic> toJson() => {
     "application_date": applicationDate,
     "manufacturing_date": manufacturingDate,
     "expiration_date": expirationDate,
     "dosage": dosage,
     "veterinary": veterinary,
     "petVaccinesId": petVaccinesId,
   };

}


List<Dose> parseDose(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Dose> doses = list.map((model) => Dose.fromJson(model)).toList();
  return doses;
}

Future<bool> registerDose(String vaxId) async {
  DateTime now = new DateTime.now();
  var oldDate = new DateTime(now.year, now.month - 6, now.day);
  var newDate = new DateTime(now.year, now.month + 6, now.day);
  print("ID DA VACINA: $vaxId");
  // 2021-12-03 13:18:35.517
  // 0123456789112345678
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/doses');
  var response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer ${sharedPreference.getString('accessToken').toString()}',
    },
    body: {
      "application_date": now.toString().substring(0,10),
      "manufacturing_date": oldDate.toString().substring(0,10),
      "expiration_date": newDate.toString().substring(0,10),
      "dosage": "5 ML",
      "veterinary": "George",
      "petVaccinesId": vaxId
    },
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("Dose registrada");
    return true;
  } else {
    print("Resposta: ${response.statusCode}");
    print(jsonDecode(response.body));
    return false;
  }
}

Future<List<Dose>> fetchDoses(String petVaccinesId) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/doses/$petVaccinesId');
  final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken').toString()}',
      }
  );
  if (response.statusCode == 200){
    print("Doses dessa vacina: ${response.body}");

    var computado = compute(parseDose, response.body);
    //print(json.encode(parseDose(response.body)));
    return computado;

  }else{
    print("RESPOSTA: ${response.statusCode}");
    //print("PETS REGISTRADOS: ${response.body}");
    throw Exception('API ERROR ${response.body}');
  }
}