import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/http_client.dart';


class RedirectPage extends StatefulWidget {
  final String? accessToken;
  final String? username;

  const RedirectPage({super.key, this.accessToken, this.username});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  final storage = const FlutterSecureStorage();
  final client = HttpClient();

  @override
  void initState() {
    super.initState();
    _handleRedirect();
  }

  _handleRedirect() async {

    try {

      if (widget.accessToken != null && widget.username != null) {
        final accessToken = decodeVariable(widget.accessToken!);
        final username = decodeVariable(widget.username!);
        await storage.write(key: 'jwt', value: accessToken);
        await storage.write(key: 'username', value: username);
      }
      
      final historyResponse = await client.getHistory();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('history', jsonEncode(historyResponse.data));

      final analysisResponse = await client.getAnalysisById(historyResponse.data.last['id']);

      await prefs.setString('text', analysisResponse.article);
      await prefs.setString('response', jsonEncode(analysisResponse.result.toJson()));

      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/result', (route) => false);
      }

    } catch (e) {
      return e;
    }

  }

  String decodeVariable(String variable) {
  try {
    final bytes = base64Decode(variable);
    final decoded = latin1.decode(bytes);
    return decoded;
  } catch (e) {
    return 'DECODE_FAILED';
  }
}
 

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}