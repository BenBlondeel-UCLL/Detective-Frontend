import 'package:flutter/material.dart';

import '../features/header.dart';
import '../features/history_drawer.dart';
import '../features/signup_card.dart';
import '../api/http_client.dart';

class Signup extends StatelessWidget {
  final HttpClient? httpClient;
  const Signup({super.key, this.httpClient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Column(
        children: [
          Header(title: "Registratie"), // Fixed at the top
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
