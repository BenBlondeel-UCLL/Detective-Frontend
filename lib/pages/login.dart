import 'package:flutter/material.dart';

import '../features/header.dart';
import '../features/history_drawer.dart';
import '../features/login_card.dart';

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
