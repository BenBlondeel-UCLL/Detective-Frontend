import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/history_drawer.dart';
import '../features/header.dart';
import '../features/input_field.dart';
import '../api/http_client.dart';
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

  Future<void> _analyzeText() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await client.postAnalysis(textEditingController.text);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentAnalysis', jsonEncode(response));

      // Fill in history
      final historyResponse = await client.getHistory();
      if(historyResponse != null && historyResponse.statusCode != null && historyResponse.statusCode == 200) {
        await prefs.setString('history', jsonEncode(historyResponse.data));
      }

      if (mounted) {
        Navigator.pushNamed(context, '/result');
      }
    } catch (e) {
      if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(skipTraversal: true)..requestFocus(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter &&
            HardwareKeyboard.instance.isControlPressed &&
            !_isLoading) {
          _analyzeText();
        }
      },
      child: Scaffold(
        drawer: HistoryDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Header(title: "Critify"),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      textEditingController: textEditingController,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: Sizes.spaceBetweenItems),
                    SizedBox(
                      width: Sizes.buttonWidth,
                      height: Sizes.buttonHeight * 2.5,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _analyzeText,
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
                        child:
                            _isLoading
                                ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: CustomColors.secondary,
                                    strokeWidth: 2.0,
                                  ),
                                )
                                : const Text(
                                  "Analyseer",
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
      ),
    );
  }
}
