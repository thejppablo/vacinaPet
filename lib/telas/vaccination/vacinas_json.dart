import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part '../../auto_json/vacinas.g.dart';

@JsonSerializable()
class Vacinas{
  final String id;
  final String name;

  Vacinas(this.id,this.name);

  factory Vacinas.fromJson(Map<String,dynamic> data) => _$VacinasFromJson(data);

  Map<String,dynamic> toJson() => _$VacinasToJson(this);

}

List<Vacinas> parseVacinas(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Vacinas> vacinas = list.map((model) => Vacinas.fromJson(model)).toList();
  return vacinas;
}

Future<List<Vacinas>> fetchVacinas() async{
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cvd-pets.herokuapp.com/vaccines');
  final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${sharedPreference.getString('accessToken').toString()}',}
  );
  if (response.statusCode == 200){
    print("VACINAS REGISTRADOS: ${response.body}");
    print(response.body.runtimeType);
    return compute(parseVacinas, response.body);
  }else{
    print("RESPOSTA: ${response.statusCode}");
    print("VacinaS REGISTRADOS: ${response.body}");
    throw Exception('API ERROR ${response.body}');
  }
}

