import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/pets/pets.dart';
import 'package:vacina_pet/telas/vaccination/vacinas_json.dart';

class PetVaccineList extends StatefulWidget {
  final Pet pet;
  PetVaccineList(this.pet);

  @override
  _PetVaccineListState createState() => _PetVaccineListState();
}

class _PetVaccineListState extends State<PetVaccineList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: getPetVax(widget.pet.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {

              return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("${snapshot.data[index].name}"),

                    );
                  }
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
}
