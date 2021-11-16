import 'package:http/http.dart' as http;

class PetVaccines{

  final String vaccineId;
  final String petId;
  final Dose doses;

  PetVaccines(this.vaccineId, this.petId,this.doses);

  PetVaccines.fromJson(Map<String, dynamic> json) :
      vaccineId = json['vaccineId'],
      petId = json['petId'],
      doses = Dose.fromJson(json['doses']);

  Map<String, dynamic> toJson() =>{
    'vaccineId' : vaccineId,
    'petId' : petId,
    'doses' : doses.toJson()};

}

class Dose{
  final String applicationDate;
  final String manufacturingDate;
  final String expirationDate;
  final int order;
  final String dosage, veterinary, petVaccinesId;

  Dose(this.applicationDate,this.manufacturingDate,this.expirationDate,
      this.order,this.dosage,this.veterinary,this.petVaccinesId);

  Dose.fromJson(Map<String, dynamic> json) :
      applicationDate = json['application_date'],
      manufacturingDate = json['manufacturing_date'],
      expirationDate = json['expiration_date'],
      order = json['order'],
      dosage = json['dosage'],
      veterinary = json['veterinary'],
      petVaccinesId = json['petVaccinesId'];

  Map<String, dynamic> toJson() =>{
    'application_date' : applicationDate,
    'manufacturing_date' : manufacturingDate,
    'expiration_date' : expirationDate,
    'order' : order,
    'dosage': dosage,
    'veterinary' : veterinary,
    'petVaccinesId' : petVaccinesId
  };
}