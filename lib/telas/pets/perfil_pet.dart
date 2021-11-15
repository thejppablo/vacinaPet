import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/pets/home_page.dart';
import 'package:vacina_pet/telas/pets/pets.dart';
import 'pets.dart';

class PerfilPet extends StatelessWidget {
  final Pet pet;
  //const PerfilPet({Key? key, required this.pet}) : super(key: key);
  PerfilPet(this.pet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        backgroundColor: Colors.red,
        actions: [IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async{
            await deletePet(pet.id);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          })],
      ),
      body: Column(children: [
        Text(pet.animalRace),
        Text("Altura: ${pet.height}"),
        Text("Peso: ${pet.weight}"),
        Text("Sexo: ${pet.sex}"),
        Text(pet.birthDate)
      ],)
    );
  }
}
