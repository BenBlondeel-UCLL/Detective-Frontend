    
import 'dart:convert';

import 'package:detective/constants/colors.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/domain/analysis.dart';
import 'package:detective/domain/analysis_history_response.dart';
import 'package:flutter/material.dart';
import 'package:detective/api/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HistoryDrawer extends StatefulWidget {

  const HistoryDrawer({super.key});

  @override
  State<HistoryDrawer> createState() => _HistoryDrawerState();
}

class _HistoryDrawerState extends State<HistoryDrawer> {


  final client = HttpClient();

  List<AnalysisHistoryResponse> _response = [];
  
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }


  void _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final responseJsonList = jsonDecode(prefs.getString('history')!);
    setState(() {
      _response = responseJsonList?.forEach((responseJson) => AnalysisHistoryResponse.fromJson(responseJson)).toList() ?? [];  
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
                  Text('History', style: TextStyle(color: CustomColors.secondary),),
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
            ListTile(
              title: Text('login'),
              subtitle: Text("2020-01-01"),
              onTap: () {
                print(_response);
              } ,
            ),
          ],
        ),
      );
  }
}
    
    