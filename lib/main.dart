import 'package:detective/pages/about.dart';
import 'package:detective/pages/result.dart';
import 'package:detective/pages/login.dart';
import 'package:detective/pages/signup.dart';
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
        scaffoldBackgroundColor: const Color(0xffE6F2F5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/result': (context) => Result(),
        '/about': (context) => const About(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}