import 'package:detective/domain/analysis.dart';
import 'package:detective/features/header.dart';
import 'package:detective/features/input_field.dart';
import '../api//http_client.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController textEditingController = TextEditingController();
  final client = HttpClient();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(title: "Detective"),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputField(textEditingController: textEditingController),
                  const SizedBox(height: Sizes.spaceBetweenItems),
                  SizedBox(
                    width: Sizes.buttonWidth,
                    height: Sizes.buttonHeight * 2.5,
                    child: ElevatedButton(
                      onPressed: () async {
                        Analysis response = await client.postHttp(
                          textEditingController.text,
                        );
                        if (context.mounted) {
                          Navigator.pushNamed(
                            context,
                            '/result',
                            arguments: {
                              'response': response,
                              'text': textEditingController.text,
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        foregroundColor: CustomColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.buttonRadius,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                      ),
                      child: const Text(
                        "Analyse",
                        style: TextStyle(fontSize: 16.0),
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
