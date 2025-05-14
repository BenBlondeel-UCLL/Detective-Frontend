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
            const Header(title: "Detective"),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: [
                  InputField(),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement analysis button logic
                        Navigator.pushNamed(context, '/analysis');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      child: Text("Analyse"),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final client = HttpClient();
                final response = await client.getHttp();
                print(response);
              },
              child: Text("Press Me"),
            ),
          ],
        ),
      ),
    );
  }
}
