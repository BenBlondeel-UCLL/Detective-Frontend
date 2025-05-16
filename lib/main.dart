import 'package:detective/pages/about.dart';
import 'package:detective/pages/analysis.dart';
import 'package:detective/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/about',
      routes: {
        '/': (context) => const Home(),
        '/analysis': (context) => const Analysis(),
        '/about': (context) => const About(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}