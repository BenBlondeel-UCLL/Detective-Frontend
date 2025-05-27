import 'package:detective/api/http_client.dart';
import 'package:detective/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:detective/constants/colors.dart';

class Header extends StatelessWidget {
  final String title;
  Header({super.key, required this.title});


  final client = HttpClient();


  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    void showLogoutConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
          backgroundColor: CustomColors.primary,
          title: const Text('Confirm Logout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: CustomColors.secondary)),
          content: const Text('Are you sure you want to log out?', style: TextStyle(fontSize: 16, color: CustomColors.secondary)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),

                ),
                child: const Text('Cancel', style: TextStyle(color: CustomColors.secondary)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                child: const Text('Logout', style: TextStyle(color: CustomColors.secondary)),
              ),
            ],
          );
        },
      );
    }

    return FutureBuilder<String?>(
      future: storage.read(key: 'jwt'),
      builder: (context, snapshot) {
        final jwt = snapshot.data;
        return Container(
            width: MediaQuery.of(context).size.width,
            height: Sizes.headerHeight,
            decoration: const BoxDecoration(
              color: CustomColors.primary,
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    alignment: FractionalOffset.centerLeft,
                    onPressed: () => {Scaffold.of(context).openDrawer()},
                    icon: const Icon(Icons.menu, color: CustomColors.secondary, size: Sizes.iconSize),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: Sizes.fontSizeTitle, color: CustomColors.secondary),
                      ),
                    ),
                  ),
                  (jwt == null)
                      ? ElevatedButton(
                          onPressed: () { Navigator.pushNamed(context, '/login'); },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          child: const Text('Login', style: TextStyle(color: CustomColors.secondary)),
                        )
                      : Row(
                          children: [
                            FutureBuilder<String?>(
                              future: storage.read(key: 'username'),
                              builder: (context, usernameSnapshot) {
                                final username = usernameSnapshot.data ?? '';
                                return Text('Welcome $username', style: const TextStyle(color: CustomColors.secondary));
                              },
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                showLogoutConfirmationDialog(context, () {
                                  Navigator.pushNamed(context, '/login');
                                  storage.delete(key: 'jwt');
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                              child: const Text('Logout', style: TextStyle(color: CustomColors.secondary)),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
      },
    );
  }
}
