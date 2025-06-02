import 'package:detective/features/header.dart';
import 'package:detective/features/history_drawer.dart';
import 'package:detective/features/login_card.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Column(
        children: [
          Header(title: "Login"),
          const LoginCard()
        ],
      ),
    );
  }
}
