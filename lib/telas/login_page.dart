import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vacina_pet/telas/home_page.dart';
import 'package:vacina_pet/telas/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formkey,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                height: 250,
                child: Image.asset('assets/images/VacinaPet.jpg'),
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Usuário',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top:15),
                    child: Icon(
                        Icons.account_box_outlined,
                    ),
                  ),
                ),
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                validator: (username) {
                  if (username == null || username.isEmpty) {
                    return 'Por favor, digite seu usuário';
                  }
                  return null;
                },
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top:15),
                    child: Icon(
                      Icons.lock_outlined
                    ),
                  ),
                ),
                controller: _passwordController,
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
                width: 30.0,
              ),
              Container(
                height: 5,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.resolveWith((states) => Colors.red),
                ),
                onPressed: () async {

                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (_formkey.currentState!.validate()) {
                    bool validResponse = await login();
              ///o foco nesse caso seria o teclado do celular aberto
                    if (!currentFocus.hasPrimaryFocus) {
              ///se ele tem o foco atual ele é desfocado e o teclado sera fechado
                      currentFocus.unfocus();
                    }
              ///se a função login retornar true essa pagina é apagada e o app troca para a HomePage
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

                child: Text("Login",
                  style: TextStyle(
                      fontSize: 20
                ),
              ),),


              Container(
                height: 150,
                child: Align(
                  alignment: Alignment(-0.70,1.00),
                child: Text('Não possui uma conta?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                )),
                        ),

                 /* style: TextButton.styleFrom(
                      primary: Colors.black54
                  ),

                  onPressed: (){
                  },
                  child: Text("Não possui uma conta?"),


              ),*/

              ElevatedButton(


                style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.resolveWith((states) => Colors. red)
                ),
                  onPressed: (){


                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CadastroPage())
                    );
                  },
                child: Text("Cadastre-se",
                style: TextStyle(
                  fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
  );
}



  final snackBar = SnackBar(
    content: Text(
      "e-mail ou senha são inválidos",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://cvd-pets.herokuapp.com/auth/login');
    var response = await http.post(
      url,
      body: {
        "username": _usernameController.text,
        "password": _passwordController.text,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
  ///salva o token localmente pelo shared_preferences o primeiro arg é a key e o segundo é o valor salvo
      await sharedPreferences.setString('token', 'Token ${jsonDecode(response.body)['token']}');
      //print(jsonDecode(response.body)['token']);
      //print("Resposta: ${response.statusCode}");
      return true;
    } else {
      //print("Resposta: ${response.statusCode}");
      //print(jsonDecode(response.body));
      return false;
    }
  }
}
