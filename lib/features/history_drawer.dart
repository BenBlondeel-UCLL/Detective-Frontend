    
import 'package:detective/constants/colors.dart';
import 'package:detective/constants/sizes.dart';
import 'package:flutter/material.dart';

class HistoryDrawer extends StatelessWidget {

  const HistoryDrawer({super.key});

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
                Navigator.pushNamed(context, '/'); // Close drawer
              },
            ),
            ListTile(
              title: Text("login"),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      );
  }
}
    
    