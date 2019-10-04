import 'package:flutter/material.dart';
import 'package:symposium_todo/home.dart';

void main() => runApp(SymposiumTodoApp());

class SymposiumTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symposium Todo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFFBC503),
          accentColor: Color(0xFF2EA5C4)),
      home: TodoHomeScreen(),
    );
  }
}
