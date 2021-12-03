import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/pets/pets.dart';
import 'package:vacina_pet/telas/vaccination/register_vaccine.dart';
import 'package:vacina_pet/telas/vaccination/vacinas_json.dart';

class PetVaccineList extends StatefulWidget {
  final Pet pet;
  PetVaccineList(this.pet);

  @override
  _PetVaccineListState createState() => _PetVaccineListState();
}

class _PetVaccineListState extends State<PetVaccineList> {
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: getPetVax(widget.pet.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                body: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    //separatorBuilder: (_, __) => Divider(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.redAccent,
                          title: Text(
                            "${snapshot.data[index].name}",
                            style: TextStyle(color: Colors.white,fontSize: 20),),

                        ),
                      );
                    }
                    ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  //onPressed: navigateSecondPage,
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (context) => ListViewVax(widget.pet.id,snapshot.data));
                    Navigator.push(context, route).then(onGoBack);
                  },
                ),
              );

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
  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }


}
