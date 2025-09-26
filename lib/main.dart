//import 'package:challenges/screens/loading_dots.dart';
//import 'package:challenges/screens/physics_playground.dart';
import 'package:challenges/screens/task_management.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: TaskManagement(),
    );
  }
}
