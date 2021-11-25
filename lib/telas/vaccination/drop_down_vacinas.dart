import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacina_pet/telas/vaccination/vacinas_json.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: DropDownVax()
        ),
      ),
    );
  }
}



class DropDownVax extends StatefulWidget {
  const DropDownVax({Key? key}) : super(key: key);

  @override
  _DropDownVaxState createState() => _DropDownVaxState();
}

class _DropDownVaxState extends State<DropDownVax> {
  int? vaxIndex;
  Vacinas? chosenVax;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchVacinas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print("TIPO DO SNAPSHOT ${snapshot.data.runtimeType}");
          //var jsonNames = snapshot.data.map((key) => key.name).toList();
          //List<String> vaxNames = List<String>.from(jsonNames);

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${snapshot.data[index].name}"),
                  onTap: () {
                    chosenVax = snapshot.data[index];
                    print("TIPO DO OBJETO ${snapshot.data[index]}");
                    vaxIndex = index;
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
           /* Container(
            margin: EdgeInsets.only(top: 20, right: 16, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 1),
            ),

            child: DropdownButtonFormField<String>(
                decoration: InputDecoration.collapsed(hintText: 'Vacinas'),
                value: vax,
                iconSize: 36,
                icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                isExpanded: true,
                items: vaxNames.map(buildMenuItem).toList(),
                onChanged: (value) => setState(()  {
                  snapshot.data.vax;
                  vax = value;
                }),
                validator: (value) => value == null ? 'Favor escolher uma vacina' : null
            ),

          ); */
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
