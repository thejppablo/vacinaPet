import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/user/boas_vindas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VacinaPet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Casa(),
    );
  }
}

class Casa extends StatefulWidget {
  const Casa({Key? key}) : super(key: key);

  @override
  _CasaState createState() => _CasaState();
}

class _CasaState extends State<Casa> {
  final sexes = ['Macho','Fêmea'];
  String? sex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1),
        ),

        child: DropdownButtonFormField<String>(
          decoration: InputDecoration.collapsed(hintText: ''),
          value: sex,
          iconSize: 36,
          icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
          isExpanded: true,
          items: sexes.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => sex = value),
        ),

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



