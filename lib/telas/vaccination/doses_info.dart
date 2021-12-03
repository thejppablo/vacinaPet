import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/vaccination/dose.dart';

class ListDoses extends StatefulWidget {
  final String petVaccinesId;
  ListDoses(this.petVaccinesId);
  //const ListDoses({Key? key}) : super(key: key);

  @override
  _ListDosesState createState() => _ListDosesState();
}

class _ListDosesState extends State<ListDoses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: fetchDoses(widget.petVaccinesId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.redAccent,
                      title: Column(

                        children: [
                          Text("Data de aplicação: ${dateRecieve(snapshot.data[index].applicationDate.toString())}",style: TextStyle(color: Colors.white,fontSize: 20)),
                          Text("Data de Fabricação: ${dateRecieve(snapshot.data[index].manufacturingDate)}",style: TextStyle(color: Colors.white,fontSize: 20)),
                          Text("Data de validade: ${dateRecieve(snapshot.data[index].expirationDate)}",style: TextStyle(color: Colors.white,fontSize: 20)),
                          Text("Dosagem: ${snapshot.data[index].dosage}",style: TextStyle(color: Colors.white,fontSize: 20)),
                          Text("Veterinário: ${snapshot.data[index].veterinary}",style: TextStyle(color: Colors.white,fontSize: 20)),

                        ],
                      ),
                      //subtitle: Text("Raça: ${snapshot.data[index].animalRace}"),
                      onTap: () {Navigator.pop(context);},
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            print("erro na montagem da lista de doses");
            print(snapshot.error);
            return Container(
              child: Center(child: Text("${snapshot.error}")),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(color: Colors.red,),
              ),
            );
          }
        },
      ),
    );
  }
}

String dateRecieve(String date){
// 2021-12-03T21:51:03.266Z
// 0123456789
print("DATA ");
print(date);
  String day = date.substring(8,10);
  String month = date.substring(5,7);
  String year = date.substring(0,4);

  return "$day/$month/$year";
}