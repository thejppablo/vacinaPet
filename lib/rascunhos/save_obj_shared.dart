import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  loadData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

  }
  saveData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final testUser = User(name: "Test User",email: "test@gmail.com",age: 35);
    String json = jsonEncode(testUser);
    prefs.setString('keyUser', json);
  }
  clearData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: saveData, child: Text("Save Data")),
          ElevatedButton(onPressed: saveData, child: Text("Save Data")),
          ElevatedButton(onPressed: saveData, child: Text("Save Data")),
        ],
      ),
    );
  }
}

class User{
  String name;
  String email;
  int age;

  User({required this.name,required this.email,required this.age});

}