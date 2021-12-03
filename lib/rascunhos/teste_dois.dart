import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/pets/pets.dart';
import 'package:vacina_pet/telas/vaccination/vacinas_json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(onPressed: () {
            DateTime now = new DateTime.now();
            print(dateSend("09/07/2010"));
            //await fetchVacinas();
          },
              child: Text("press me :)")),
        ),
      ),
    );
  }
}


String dateSend(String date){
// 9 9 - 9 9 - 9 9 9 9
// 0 1 2 3 4 5 6 7 8 9
  String day = date.substring(0,2);
  String month = date.substring(3,5);
  String year = date.substring(6);

  return "$year-$month-$day";
}