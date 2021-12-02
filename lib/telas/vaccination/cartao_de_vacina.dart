import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/pets/perfil_pet.dart';
import 'package:vacina_pet/telas/pets/pets.dart';
import 'package:vacina_pet/telas/vaccination/pet_vaccine_list.dart';

import 'register_vaccine.dart';

/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartaoVacina(),
    );
  }
}
*/

class CartaoVacina extends StatefulWidget {
  final Pet pet;
  CartaoVacina(this.pet);
  //const CartaoVacina({Key? key, required this.pet}) : super(key: key);

  @override
  _CartaoVacinaState createState() => _CartaoVacinaState();
}

class _CartaoVacinaState extends State<CartaoVacina> {

  int currentIndex = 0;

  String titulo = "Vacinas";


  @override
  Widget build(BuildContext context) {
    final appbarTitles = ["Vacinas","Vermífugos","${widget.pet.name}"];
    final screens = [
      PetVaccineList(widget.pet),
      ListViewVax(widget.pet.id),
      //Center(child: Text("Vermífugos",style: TextStyle(fontSize: 60),)),
      PerfilPet(widget.pet)
    ];
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "$titulo",
              style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.red,
          centerTitle: true,
      ),
      body: IndexedStack(
          index: currentIndex,
          children: screens
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        //onTap: (index) => setState(() => currentIndex = index),
        onTap: (index) {
          setState(() {
            currentIndex = index;
            titulo = appbarTitles[index];
          });
        },
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Vacinas',
              //backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Vermífugos',
            //backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Perfil',
              //backgroundColor: Colors.blue
          )
        ],
      ),
    );
  }
}