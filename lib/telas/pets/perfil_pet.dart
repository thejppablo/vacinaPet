import 'package:flutter/material.dart';
import 'package:vacina_pet/telas/pets/home_page.dart';
import 'package:vacina_pet/telas/pets/pets.dart';
import 'pets.dart';

class PerfilPet extends StatefulWidget {
  final Pet pet;
  //const PerfilPet({Key? key, required this.pet}) : super(key: key);
  PerfilPet(this.pet);

  @override
  _PerfilPetState createState() => _PerfilPetState();
}

class _PerfilPetState extends State<PerfilPet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text(widget.pet.name),
        backgroundColor: Colors.grey,
        actions: [IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              await deletePet(widget.pet.id);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            })],
      ), */
      body: ListView(
        //physics: NeverScrollableScrollPhysics(),
        children: [
          //Color(0xFFECEFF1)
          Container(color: Color(0xFFECEFF1),child: Center(child:
          Text(widget.pet.animalRace, style:
          TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
            height: 60,

          ),

          CustomWidget("Altura: ",widget.pet.height,"(M)",Colors.white),
          CustomWidget("Peso: ",widget.pet.weight,"(Kg)",Colors.white),
          CustomWidget("Sexo: ",widget.pet.sex,"",Colors.white),
          CustomWidget("Dt de nasc: ",
              "${widget.pet.birthDate.substring(8,10)}/"
                  "${widget.pet.birthDate.substring(5,7)}/"
                  "${widget.pet.birthDate.substring(0,4)}","",Colors.white),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async{
                await deletePet(widget.pet.id);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              })

        ],
      ),
      /*
      bottomNavigationBar: BottomAppBar(

        child: Container(
          height: 60,

          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Carteira de Vacinação",style: TextStyle(fontSize: 25),),

                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Icon(Icons.search,size: 35,),
                  )
                ],
              ),
              onPressed: (){},
            ),
          ),
        ),
      ), */
    );
  }
}


class CustomWidget extends StatelessWidget {
  final String prefix;
  final String inputText;
  final String sufix;
  final Color color;
  //const CustomWidget({Key? key, required this.inputText}) : super(key: key);

  CustomWidget(this.prefix,this.inputText,this.sufix,this.color);

  @override
  Widget build(BuildContext context) {
    return Container(

      //padding: EdgeInsets.only(top: 10),
      height: 100,
      padding: EdgeInsets.only(left: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(prefix,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
          ),),
          Text(inputText,
              style:
          TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          )),
          Text(sufix,
              style:
              TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              )),
        ],
      ),
      decoration: BoxDecoration(
        color: color,
          border: Border(
              bottom: BorderSide(color: Colors.black)
          )
      ),);
  }
}
