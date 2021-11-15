import 'package:flutter/material.dart';

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
      ),
    );
  }
}
