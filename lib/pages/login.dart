import 'package:critify/features/header.dart';
import 'package:critify/features/history_drawer.dart';
import 'package:critify/features/login_card.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Column(
        children: [
          Header(title: "Aanmelden"), // Fixed at the top
          Expanded(
            child: SingleChildScrollView(
              child: LoginCard(),
            ),
          ),
        ],
      ),
    );
  }
}
