import 'package:flutter/material.dart';
import 'package:referendum/home/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Referendum',
      routes: {
        HomeScreen.path: (ctx) => HomeScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
