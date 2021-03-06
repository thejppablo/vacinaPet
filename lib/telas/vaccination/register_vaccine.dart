import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/vaccination/pet_vaccines.dart';
import 'package:vacina_pet/telas/vaccination/vacinas_json.dart';
import 'dose.dart';

class ListViewVax extends StatefulWidget {
  final String petId;
  final List<Vacinas> vacinas_do_pet;
  ListViewVax(this.petId,this.vacinas_do_pet);
  //const ListViewVax({Key? key, required this.petId}) : super(key: key);

  @override
  _ListViewVaxState createState() => _ListViewVaxState();
}

class _ListViewVaxState extends State<ListViewVax> {
  //int? vaxIndex;
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
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,),
      body: FutureBuilder(
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
                    onTap: ()  async{
                      /*
                      lista.add(dose);
                      PetVaccines chosenVax = PetVaccines(
                          vaccineId: snapshot.data[index].id,
                          petId: widget.petId,
                          doses: lista,
                      );
                      await postVaccines(chosenVax,dose);
                      */
                      bool isVaxIn = false;
                      var chosenVaxObj = snapshot.data[index];
                      for(int indice = 0; indice < widget.vacinas_do_pet.length; indice++){
                        if(widget.vacinas_do_pet[indice].name == chosenVaxObj.name){
                          print("JA TEM A VACINA ${widget.vacinas_do_pet[indice].name}");
                          isVaxIn = true;
                          await registerDose();
                        }
                      }
                      if(isVaxIn == false){
                        print("Vacina nao registrada no pet");
                        lista.add(dose);
                        PetVaccines chosenVax = PetVaccines(
                          vaccineId: snapshot.data[index].id,
                          petId: widget.petId,
                          doses: lista,
                        );
                        await postVaccines(chosenVax,dose);
                      }
                      //print("quebrou");
                      Navigator.pop(context);

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
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item,
      style: TextStyle( fontSize: 20),
    ),
  );
}
