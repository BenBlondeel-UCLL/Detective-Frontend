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

  Future<void> _handleRedirect() async {
    print("handleRedirect called");
    print("Access Token: ${widget.accessToken}");
    print("Username: ${widget.username}");

    if (widget.accessToken != null && widget.username != null) {
      await storage.write(key: 'jwt', value: widget.accessToken);
      await storage.write(key: 'username', value: widget.username);
    }
    
    final historyResponse = await client.getHistory();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('history', jsonEncode(historyResponse.data));

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}