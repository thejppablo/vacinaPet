import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vacina_pet/telas/pets/home_page.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Form(
          key: _formkey,
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'nome',
                    ),
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Por favor, digite seu nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'e-mail',
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Por favor, digite seu e-mail';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.text)) {
                        return 'Por favor, insira um e-mail válido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'CPF',
                    ),
                    controller: _cpfController,
                    keyboardType: TextInputType.text,
                    validator: (cpf) {
                      if (cpf == null || cpf.isEmpty) {
                        return 'Por favor, digite seu cpf';
                      } else if (cpf.length != 11) {
                        return 'Por favor, digite um cpf com 9 caracteres';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'senha',
                    ),
                    controller: _passwordController,
                    //obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Por favor, digite sua senha';
                      } else if (password.length < 6) {
                        return 'Por favor, digite uma senha maior que 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (_formkey.currentState!.validate()) {
                        bool validResponse = await registerUser();
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
                          _passwordController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text("Cadastrar-se"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  final snackBar = SnackBar(
    content: Text(
      "e-mail ou senha são inválidos",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  Future<bool> registerUser() async {
    var url = Uri.parse('https://cvd-pets.herokuapp.com/user');
    var response = await http.post(
      url,
      body: {
        "name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "cpf": _cpfController.text
      },
    );
    if (response.statusCode == 201) {
      print("DEU BOM");
      print(jsonDecode(response.body)['accessToken']);
      return true;
    } else {
      print("Resposta: ${response.statusCode}");
      print(jsonDecode(response.body));
      return false;
    }
  }
}
