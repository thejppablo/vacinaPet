import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacina_pet/telas/pets/pets.dart';
import 'package:vacina_pet/telas/user/boas_vindas.dart';
import 'package:vacina_pet/telas/pets/pet_register.dart';
import 'package:vacina_pet/telas/pets/perfil_pet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Meus Pets"),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.logout),
              onPressed: () async{

                bool isLoggedOff = await logOff();
                if(isLoggedOff){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BoasVindasPage()));
                }
              }
          )
      ],
      ),
      body: PetList(),

      bottomNavigationBar: BottomAppBar(
        child:
            /*
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red)),
              onPressed: () {},
              child: Text(
                "Excluir Pet",
                style: TextStyle(fontSize: 20),
              ),
            ),
            */

            Container(
              padding: EdgeInsets.only(left:10,right: 10,bottom: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PetRegister()));
                },
                child: Text(
                  "Cadastrar Pet",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

      ),
    );
  }

  Future<bool> logOff() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

}

class PetList extends StatefulWidget {
  const PetList({Key? key}) : super(key: key);

  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPet(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                        //leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].url),),
                        title: Text("Nome: ${snapshot.data[index].name}"),
                        subtitle: Text("Raça: ${snapshot.data[index].animalRace}"),
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => PerfilPet(snapshot.data[index])));
                        },
                      );
              }
          );
        }else if(snapshot.hasError){
          print(snapshot.error);
          return Container(
            child: Center(
                child: Text("Data not found")),
          );
        }else{
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
