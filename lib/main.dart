import 'package:detective/api/http_client.dart';
import 'package:detective/pages/about.dart';
import 'package:detective/pages/result_page.dart';
import 'package:detective/pages/login.dart';
import 'package:detective/pages/signup.dart';
import 'package:detective/pages/home.dart';
import 'package:flutter/material.dart';

void main({HttpClient? httpClient}) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(httpClient: httpClient));
}

class MyApp extends StatelessWidget {
  final HttpClient? httpClient;
  const MyApp({super.key, this.httpClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detective',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: const Color(0xffE6F2F5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/result': (context) => ResultPage(),
        '/about': (context) => const About(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(httpClient: httpClient),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}