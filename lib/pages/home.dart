import 'package:detective/features/header.dart';
import 'package:detective/features/input_field.dart';
import '../api//http_client.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final client = HttpClient();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 30,
          children: [
            const Header(title: "Detective"),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const InputField(),
                  const SizedBox(height: Sizes.spaceBetweenItems),
                  SizedBox(
                    width: Sizes.buttonWidth,
                    height: Sizes.buttonHeight * 2.5,
                    child: ElevatedButton(
                      onPressed: () async {
                        await client.postHttp();
                        if (context.mounted) {
                          Navigator.pushNamed(context, '/analysis');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        foregroundColor: CustomColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Sizes.buttonRadius),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      ),
                      child: const Text(
                        "Analyse",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
