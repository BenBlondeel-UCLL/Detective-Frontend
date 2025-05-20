import 'package:detective/features/header.dart';
import 'package:detective/features/signup_card.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(title: "signup"),
          SignupCard(),
        ],
      ),
    );
  }
}
