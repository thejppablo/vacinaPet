import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pet {
  final String id;
  final String name;
  final String animalRace;
  final String? image;
  final String height;
  final String weight;
  final String birthDate;
  final String sex;

  Pet(this.id,this.name, this.animalRace,this.image,this.height,
      this.weight,this.birthDate,this.sex);

  /*
  fromJson() constructor, for constructing a new User instance from a map structure.
  A toJson() method, which converts a User instance into a map.
  */

/// converts from map to Pet object
  Pet.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        name = json['name'],
        animalRace = json['animal_race'],
        image = json['image'],
        height = json['height'],
        weight = json['weight'],
        birthDate = json['birth_date'],
        sex = json['sex'];

/// converts from Pet object to map
  Map<String, dynamic> toJson() => {

    'id' :id,
    'name':name,
    'animal_race': animalRace,
    'image':image,
    'height':height,
    'weight':weight,
    'birth_date':birthDate,
    'sex':sex
  };
}

///transforma a resposta do servidor em uma lista de objetos da classe
List<Pet> parsePet(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Pet> pets = list.map((model) => Pet.fromJson(model)).toList();
  return pets;
}

Future<List<Pet>> fetchPet() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/pets');
  final response = await http.get(
    url,
    headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken').toString()}',
      }
  );
  if (response.statusCode == 200){
    //print("PETS REGISTRADOS: ${response.body}");

    return compute(parsePet, response.body);/// = parsepet(response.body)

  }else{
    print("RESPOSTA: ${response.statusCode}");
    //print("PETS REGISTRADOS: ${response.body}");
    throw Exception('API ERROR ${response.body}');
  }
}

Future<bool> deletePet(String petId) async{
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/pets/$petId');
  final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ${sharedPreference.getString('accessToken').toString()}',
      }
  );
  if (response.statusCode == 204){
    //print("PETS REGISTRADOS: ${response.body}");
    return true;
  }else{
    print("RESPOSTA: ${response.statusCode}");
    throw Exception('API ERROR ${response.body}');
  }
}

