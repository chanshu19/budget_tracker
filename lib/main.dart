import 'package:budget_tracker/pages/home_page.dart';
import 'package:budget_tracker/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: myTheme,
      home: const MyHomePage(),
    );
  }
}


