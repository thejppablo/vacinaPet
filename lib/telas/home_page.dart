import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacina_pet/telas/boas_vindas.dart';
import 'package:vacina_pet/telas/pet_register.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Home Page",textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

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
            SizedBox(width: 30,),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PetRegister()));
              },
              child: Text(
                "Adicionar Pet",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],)
        ],
      ),

    );
  }

  Future<bool> logOff() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

}
