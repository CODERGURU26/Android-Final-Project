import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Circular Loader',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: LoaderScreen(),
    );
  }
}

class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a task with a 5 second delay
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false; // Stop loading after 5 seconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amimated Circular Loader '),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                'Success! Task Completed.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}






