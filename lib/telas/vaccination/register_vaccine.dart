import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacina_pet/telas/vaccination/pet_vaccines.dart';
import 'package:vacina_pet/telas/vaccination/vacinas_json.dart';
import 'package:http/http.dart' as http;

import 'dose.dart';

class ListViewVax extends StatefulWidget {
  final String petId;
  ListViewVax(this.petId);
  //const ListViewVax({Key? key, required this.petId}) : super(key: key);

  @override
  _ListViewVaxState createState() => _ListViewVaxState();
}

class _ListViewVaxState extends State<ListViewVax> {
  int? vaxIndex;
  Dose dose = Dose(
      applicationDate: "2021-11-26",
      manufacturingDate: "2021-11-26",
      expirationDate: "2021-11-26",
      order: 1,
      dosage: "dose",
      veterinary: "Pedro",
      petVaccinesId: "");
  List<Dose> lista = [];
  //late PetVaccines chosenVax;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchVacinas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //print("SNAP SHOT ${snapshot.data}");
          //var jsonNames = snapshot.data.map((key) => key.name).toList();
          //List<String> vaxNames = List<String>.from(jsonNames);

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${snapshot.data[index].name}"),
                  onTap: () async {
                    lista.add(dose);
                    print("ID VACINA ${snapshot.data[index].id}");
                    PetVaccines chosenVax = PetVaccines(
                        vaccineId: snapshot.data[index].id,
                        petId: widget.petId,
                        doses: lista,
                    );
                    //print("TIPO DO OBJETO ${snapshot.data[index]}");
                    vaxIndex = index;
                    //print("ID DA VACINA: ${chosenVax.id}");
                    await postVaccines(chosenVax,dose);
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              //PerfilPet(snapshot.data[index])
                              return CartaoVacina(snapshot.data[index]);}
                        )
                    ); */
                  },
                );
              });

        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            child: Center(child: Text("${snapshot.error}")),
          );
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item,
      style: TextStyle( fontSize: 20),
    ),
  );

  /*Future<bool> vaccinatePet(List<Vacinas> lista) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var url = Uri.parse('https://cvd-pets.herokuapp.com/pet-vaccines');
    var response = await http.post(url,
        headers: {
          'Authorization': 'Bearer ${sharedPreference.getString('accessToken').toString()}',
        },
        body: {
          "vaccineId": vax,
          "petId": ,
          "doses": [],

        }
        );

  } */

}
