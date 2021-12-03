import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Dose{
   String applicationDate;
   String manufacturingDate;
   String expirationDate;
   int order;
   String dosage,
          veterinary,
          petVaccinesId;

  Dose({required this.applicationDate,
    required this.manufacturingDate,
    required this.expirationDate,
    required this.order,
    required this.dosage,
    required this.veterinary,
    required this.petVaccinesId});

  factory Dose.fromJson(Map<String, dynamic> json) => Dose(
    applicationDate: json["applicationDate"],
    manufacturingDate: json["manufacturingDate"],
    expirationDate: json["expirationDate"],
    order: json["order"],
    dosage: json["dosage"],
    veterinary: json["veterinary"],
    petVaccinesId: json["petVaccinesId"],
  );

   Map<String, dynamic> toJson() => {
     "applicationDate": applicationDate,
     "manufacturingDate": manufacturingDate,
     "expirationDate": expirationDate,
     "order": order,
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

Future<bool> registerDose() async {
  DateTime now = new DateTime.now();
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/doses');
  var response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer ${sharedPreference.getString('accessToken').toString()}',
    },
    body: {
      "application_date": "2021-12-03T08:42:41.441Z",
      "manufacturing_date": "2021-12-03T08:42:41.441Z",
      "expiration_date": "2021-12-02T23:03:51.115Z",
      "dosage": "dose",
      "veterinary": "string",
      "petVaccinesId": "string"
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