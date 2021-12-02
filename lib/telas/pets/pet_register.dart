import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';



class PetRegister extends StatefulWidget {
  const PetRegister({Key? key}) : super(key: key);

  @override
  _PetRegisterState createState() => _PetRegisterState();
}

class _PetRegisterState extends State<PetRegister> {

  final _formkey = GlobalKey<FormState>();
  final _nameController =     TextEditingController();
  final _raceController =     TextEditingController();
  final _heightController =   TextEditingController();
  final _weightController =   TextEditingController();
  final _birthDateController =    TextEditingController();
  final sexes = ['Macho','Fêmea'];
  String? _sex;
  File? image;


  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);

    } on PlatformException catch (e){
      print('Falha ao celecionar imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro Pet"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Form(
          key: _formkey,

            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10,
                  ),


                  image != null
                      ? Image.file(
                          image!,
                          height: 250,
                          fit: BoxFit.fill,
                  )
                     : FlutterLogo( size: 0),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      textStyle: TextStyle(fontSize: 20),
                    ) ,
                    onPressed: () => pickImage(),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt_outlined, size: 28,),
                        const SizedBox(width: 16),
                        Text('Inserir foto do Pet'),
                      ],
                    ),
                  ),

///           Nome
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Por favor, digite um nome';
                      }
                      return null;
                    },
                  ),
///           Raça
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Raça',
                    ),
                    controller: _raceController,
                    keyboardType: TextInputType.text,
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Por favor, digite uma raça';
                      }
                      return null;
                    },
                  ),
///           Altura
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Altura(M)',
                    ),
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Por favor, digite uma altura';
                      }
                      return null;
                    },
                  ),
///           Peso
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Peso(Kg)',
                    ),
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Por favor, digite um peso';
                      }
                      return null;
                    },
                  ),
///           Data de nascimento
                  TextFormField(
                    inputFormatters: [ TextInputMask(mask: '9999-99-99') ],
                    decoration: InputDecoration(
                      labelText: 'data de nascimento',
                    ),
                    controller: _birthDateController,
                    keyboardType: TextInputType.number,
                    // TODO: implementar um error check mais robusto
                    validator: (date) {
                      print("CCCCCCCCCCCC: ");
                      //print(date!.length);
                      print(_birthDateController.text);
                      /*
                      var ano = int.parse(_birthDateController.text.substring(4));
                      var mes = int.parse(_birthDateController.text.substring(2,4));
                      var dia = int.parse(_birthDateController.text.substring(0,2));
                      DateTime hoje = DateTime.now();
                      || ano > hoje.year
                      || ano <= 1990
                      || mes > 12 || mes < 1
                      || dia > 31 || dia < 1
                      */
                      if (date == null || date.isEmpty) {
                        return 'Por favor, digite uma data';
                      } else if (date.length != 10) {
                        return 'Por favor, digite uma data válida';
                      }
                      return null;
                    },

                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20, right: 16, bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 1),
                    ),

                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration.collapsed(hintText: 'Sexo do Pet'),
                      value: _sex,
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                      isExpanded: true,
                      items: sexes.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => _sex = value),
                      validator: (value) => value == null ? 'Favor escolher o sexo do seu pet' : null
                    ),

                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.red)),
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (_formkey.currentState!.validate()) {
                        bool validResponse = await registerPet();
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (validResponse) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          _birthDateController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text("Cadastrar-se"),
                  ),
                ],
              ),
            ),

        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item,
      style: TextStyle( fontSize: 20),
    ),
  );

  final snackBar = SnackBar(
    content: Text(
      "e-mail ou senha são inválidos",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  Future<bool> registerPet() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    var url = Uri.parse('https://cvd-pets.herokuapp.com/pets');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${sharedPreference.getString('accessToken').toString()}',
      },
      body: {
        "name": _nameController.text,
        "animal_race": _raceController.text,
        "height": _heightController.text,
        "weight": _weightController.text,
        "birth_date": _birthDateController.text,
        "sex": _sex,
        "userId": sharedPreference.getString('userId').toString(),
      },
    );
    if (response.statusCode == 201) {
      print("DEU BOM");
      return true;
    } else {
      print("Resposta: ${response.statusCode}");
      print(jsonDecode(response.body));
      return false;
    }
  }

}
