import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacina_pet/telas/boas_vindas.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Home Page",textAlign: TextAlign.center,),
          TextButton(
              onPressed: () async{
                bool isLoggedOff = await logOff();
                if(isLoggedOff){
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BoasVindasPage()));
                }
              },
              child: Text("sair"))
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
