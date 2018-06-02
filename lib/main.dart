import 'package:flutter/material.dart';
import 'package:referendum/screens/list/list_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Referendum',
      routes: {
        //    HomeScreen.path: (ctx) => HomeScreen(),
        ListScreen.path: (ctx) => ListScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
