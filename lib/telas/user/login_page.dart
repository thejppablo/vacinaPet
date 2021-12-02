import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vacina_pet/telas/pets/home_page.dart';
import 'package:vacina_pet/telas/user/register_page.dart';
import 'package:vacina_pet/api/notification_api.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool is_loading = false;

  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: is_loading ? Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ) :

        Form(
      key: _formkey,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Vacinapet", style: TextStyle(fontFamily: 'Sofadi One',fontSize: 50,height: 5),),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Usuário',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 0),
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
                    padding: EdgeInsets.only(top: 15),
                    child: Icon(Icons.lock_outlined),
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

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith((states) => Colors.red),
                ),
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      is_loading = true;
                    });
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
                      setState(() {
                        is_loading = false;
                      });
                      _passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                height: 150,
                child: Align(
                    alignment: Alignment(-0.70, 1.00),
                    child: Text(
                      'Não possui uma conta?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
              ),

              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.red)),
                onPressed: () {
                  NotificationApi.showScheduledNotification(
                    title: 'Seu Pet precisa de você!!',
                    body: 'Falta exatamente 1 Semana para a vacina do seu Pet',
                    payload: 'coisa.ruim',
                    scheduledDate: DateTime.now().add(Duration(seconds: 20)),
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CadastroPage()));
                },
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(fontSize: 20),
                ),
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
      await sharedPreferences.setString('accessToken', jsonDecode(response.body)['accessToken']);
      await sharedPreferences.setString('userId', jsonDecode(response.body)['user']['id']);
      //print("BODY DA RESPOSTA: ${jsonDecode(response.body)}");
      /*
      print("Resposta: ${response.statusCode}");
      print("ACCESS TOKKEENN:   ");
      print(jsonDecode(response.body)['accessToken']);
      print("EMAIL DO CARA:      ");
      print(jsonDecode(response.body)['user']['email']);
      */
      return true;
    } else {
      //print("Resposta: ${response.statusCode}");
      //print(jsonDecode(response.body));
      return false;
    }
  }
}

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
