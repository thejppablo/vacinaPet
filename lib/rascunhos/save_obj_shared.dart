import 'dart:async';

import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Data: $id',
              style: Theme.of(context).textTheme.headline5,
            ),
            FloatingActionButton(
              child: Text('Second Page'),
              onPressed: navigateSecondPage,
            ),
          ],
        ),
      ),
    );
  }
  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => SecondPage());
    Navigator.push(context, route).then(onGoBack);
  }

}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}




void main() => runApp(
  MaterialApp(
    //builder: (context, child) => SafeArea(child: child),
    home: HomePage(),
  ),
);
