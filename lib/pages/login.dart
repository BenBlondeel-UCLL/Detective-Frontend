import 'package:detective/features/header.dart';
import 'package:detective/features/login_card.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(title: "login"),
          const LoginCard()
        ],
      ),
    );
  }
}
