import 'package:detective/features/header.dart';
import 'package:detective/features/history_drawer.dart';
import 'package:detective/features/signup_card.dart';
import 'package:flutter/material.dart';
import 'package:detective/api/http_client.dart';

class Signup extends StatelessWidget {
  final HttpClient? httpClient;
  const Signup({super.key, this.httpClient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Column(
        children: [
          Header(title: "Signup"), // Fixed at the top
          Expanded(
            child: SingleChildScrollView(
              child: SignupCard(httpClient: httpClient),
            ),
          ),
        ],
      ),
    );
  }
}
