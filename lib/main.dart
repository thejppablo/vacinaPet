import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';

const request = "http://api.hgbrasil.com/finance?format=json&key=531bdba6";

void main() {
  runApp(MyApp()
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("VacinaPet",style: TextStyle(),),
              TextFormField(),
              TextFormField(),
              

            ],
          ),
        ),
      ),
    );
  }
}
