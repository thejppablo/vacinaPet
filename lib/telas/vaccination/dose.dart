import 'dart:convert';

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