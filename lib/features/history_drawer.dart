import 'dart:convert';

import 'package:critify/constants/colors.dart';
import 'package:critify/constants/date_utils.dart';
import 'package:critify/domain/analysis_by_id.dart';
import 'package:critify/domain/analysis_history_response.dart';
import 'package:flutter/material.dart';
import 'package:critify/api/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDrawer extends StatefulWidget {
  const HistoryDrawer({super.key});

  @override
  State<HistoryDrawer> createState() => _HistoryDrawerState();
}

class _HistoryDrawerState extends State<HistoryDrawer> {
  final client = HttpClient();

  List<AnalysisHistoryResponse> historyResponse = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  void loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final responseJsonList = jsonDecode(prefs.getString('history') ?? '[]');
    setState(() {
      historyResponse =
          (responseJsonList as List)
              .map(
                (responseJson) =>
                    AnalysisHistoryResponse.fromJson(responseJson),
              )
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  @override
  Widget build(BuildContext context) {
  return 
    Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: CustomColors.primary),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo_1.png'),
                  radius: 50,
                ),
                SizedBox(height: 10),
                Text('Geschiedenis', style: TextStyle(color: CustomColors.secondary),),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, '/');
              },
          ),          
          ...historyResponse.map(
            (hist) => Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.history),
                    title: Text(hist.title),
                    subtitle: Text(DateUtil.getDdMMyyyy(hist.createdAt)),
                    onTap: () async {
                      AnalysisById response = await client.getAnalysisById(
                        hist.id,
                      );
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('text', response.article);
                      await prefs.setString(
                        'response',
                        jsonEncode(response.result.toJson()),
                      );
                      Navigator.pushNamed(context, '/result');
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await client.deleteAnalysisById(hist.id);
                    final response = await client.getHistory();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('history', jsonEncode(response.data));
                    loadHistory();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
