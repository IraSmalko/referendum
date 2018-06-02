import 'package:flutter/material.dart';
import 'package:referendum/screens/list/list_screen.dart';
import 'package:referendum/screens/results/results.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Referendum',
      routes: {
        //HomeScreen.path: (ctx) => HomeScreen(),
        ListScreen.path: (ctx) => ListScreen(),
        ResultsScreen.path: (ctx) => ResultsScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
