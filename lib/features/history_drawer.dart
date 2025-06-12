import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../constants/date_utils.dart';
import '../domain/analysis_history_response.dart';
import '../api/http_client.dart';

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
    if (responseJsonList.isNotEmpty) {
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
    } else {
      setState(() {
        historyResponse = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                Text(
                  'Geschiedenis',
                  style: TextStyle(color: CustomColors.secondary),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                    (route) => false,
              );            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Over Critify"),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/about',
                    (route) => false,
              );
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
                      final response = await client.getAnalysisById(hist.id);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                        'currentAnalysis',
                        jsonEncode(response),
                      );
                      if (context.mounted) {
                        Navigator.pushNamed(context, '/result');
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await client.deleteAnalysisById(hist.id);
                    final response = await client.getHistory();
                    if (response.statusCode == 200) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                        'history',
                        jsonEncode(response.data),
                      );
                      loadHistory();

                      final currentAnalysisString = prefs.getString(
                        'currentAnalysis',
                      );
                      if (currentAnalysisString != null) {
                        final currentAnalysis = jsonDecode(
                          currentAnalysisString,
                        );
                        if (currentAnalysis['id'] == hist.id) {
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => false,
                            );
                          }
                        }
                      }
                    }
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
