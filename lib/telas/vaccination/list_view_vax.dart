import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/vaccination/pet_vaccines_class.dart';
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
  String chosenVaxId = "";

  List<Dose> lista = [];
  //late PetVaccines chosenVax;

  @override
  Widget build(BuildContext context) {
    DateTime now =  DateTime.now();
    var oldDate =  DateTime(now.year, now.month - 6, now.day);
    var newDate =  DateTime(now.year, now.month + 6, now.day);
    Dose dose = Dose(
        applicationDate: "${now.toString().substring(0,10)}",
        manufacturingDate: "${oldDate.toString().substring(0,10)}",
        expirationDate: "${newDate.toString().substring(0,10)}",
        dosage: "dose",
        veterinary: "Pedro",
        petVaccinesId: "");
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

                      bool isVaxIn = false;
                      var chosenVaxObj = snapshot.data[index];
                      for(int indice = 0; indice < widget.vacinas_do_pet.length; indice++){
                        if(widget.vacinas_do_pet[indice].name == chosenVaxObj.name){
                          print("JA TEM A VACINA ${widget.vacinas_do_pet[indice].name}");
                          isVaxIn = true;
                          await registerDose(widget.vacinas_do_pet[indice].id);
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
