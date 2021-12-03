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
                  return ListTile(
                    tileColor: Colors.redAccent,
                    title: Column(

                      children: [
                        Text("Data de aplicação: ${snapshot.data[index].applicationDate}",style: TextStyle(color: Colors.white,fontSize: 20)),
                        Text("Data de Fabricação: ${snapshot.data[index].manufacturingDate}",style: TextStyle(color: Colors.white,fontSize: 20)),
                        Text("Data de validade: ${snapshot.data[index].applicationDate}",style: TextStyle(color: Colors.white,fontSize: 20)),
                        Text("Dosagem: ${snapshot.data[index].dosage}",style: TextStyle(color: Colors.white,fontSize: 20)),
                        Text("Veterinário: ${snapshot.data[index].veterinary}",style: TextStyle(color: Colors.white,fontSize: 20)),

                      ],
                    ),
                    //subtitle: Text("Raça: ${snapshot.data[index].animalRace}"),
                    onTap: () {Navigator.pop(context);},
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
