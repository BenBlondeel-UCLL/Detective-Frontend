import 'package:detective/features/analyse_button.dart';
import 'package:detective/features/header.dart';
import 'package:detective/features/input_field.dart';
import 'package:detective/features/http_client.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 30,
          children: [
            const Header(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: [InputField(), SizedBox(height: 20), AnalyseButton()],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final client = HttpClient();
                final response = await client.getHttp();
                print(response);
              },
              child: const Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}
