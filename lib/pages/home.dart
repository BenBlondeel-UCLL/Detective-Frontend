import 'dart:convert';

import 'package:detective/domain/analysis.dart';
import 'package:detective/features/history_drawer.dart';
import 'package:detective/features/header.dart';
import 'package:detective/features/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HistoryDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(title: "Detective"),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputField(textEditingController: textEditingController, isLoading: _isLoading),
                  const SizedBox(height: Sizes.spaceBetweenItems),
                  SizedBox(
                    width: Sizes.buttonWidth,
                    height: Sizes.buttonHeight * 2.5,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                        setState(() {
                          _isLoading = true;

                        });

                        try {
                          Analysis response = await client.postHttp(
                            textEditingController.text,
                          );

                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('response', jsonEncode(response.toJson()));
                          await prefs.setString('text', textEditingController.text);

                          if (context.mounted) {
                            Navigator.pushNamed(
                              context,
                              '/result',
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to analyze: ${e.toString()}')),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isLoading = false;
                            });
                          }
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
                      child: _isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: CustomColors.secondary,
                          strokeWidth: 2.0,
                        ),
                      )
                          : const Text(
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
