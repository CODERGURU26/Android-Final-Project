import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Circular Loader '),
        ),
        body: Center(
          child: CircularLoader(),
        ),
      ),
    );
  }
}

class CircularLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 170, 243, 33)), // Loader color
      strokeWidth: 10.0, // Loader thickness
    );
  }
}
