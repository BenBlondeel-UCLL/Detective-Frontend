import 'dart:async';

import 'package:critify/api/http_client.dart';
import 'package:critify/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:critify/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// Helper class for responsive dimensions
class ResponsiveSize {
  static double getHeaderHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Scale down on smaller screens
    if (width < Sizes.mobileWidth) return Sizes.headerHeight * 0.85;
    return Sizes.headerHeight;
  }

  static double getFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.7;
    if (width < Sizes.mobileWidth) return baseSize * 0.85;
    return baseSize;
  }

  static double getIconSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < Sizes.mobileWidth) return Sizes.iconSize * 0.85;
    return Sizes.iconSize;
  }

  static double getSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < Sizes.mobileWidth) return 8;
    return 16;
  }
}

class Header extends StatelessWidget {
  final String title;
  Header({super.key, required this.title});

  final client = HttpClient();

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    void handleLogout() async {
      await storage.delete(key: 'jwt');
      await storage.delete(key: 'username');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('history');
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }

    void checkTokenExpiration(BuildContext context) async {
      final jwt = await storage.read(key: 'jwt');

      if (jwt != null && JwtDecoder.isExpired(jwt)) {
        handleLogout();
      }
    }

    Timer.periodic(const Duration(minutes: 1), (_) => checkTokenExpiration(context));

    void showLogoutConfirmationDialog(
        BuildContext context,
        VoidCallback onConfirm,
        ) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: CustomColors.primary,
            title: const Text(
              'Confirm Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: CustomColors.secondary,
              ),
            ),
            content: const Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontSize: 16, color: CustomColors.secondary),
            ),
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
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: CustomColors.secondary),
                ),
              ),
              ElevatedButton(
                key: const Key('logoutConfirmationButton'),
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
                child: const Text(
                  'Logout',
                  style: TextStyle(color: CustomColors.secondary),
                ),
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
        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = MediaQuery.of(context).size.width < Sizes.mobileWidth;

            return Container(
              width: MediaQuery.of(context).size.width,
              height: ResponsiveSize.getHeaderHeight(context),
              decoration: const BoxDecoration(
                color: CustomColors.primary,
                border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
              ),
              child: Stack(
                children: [
                  // Center title absolutely regardless of other elements
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: ResponsiveSize.getFontSize(context, Sizes.fontSizeTitle),
                          color: CustomColors.secondary,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Left side - Menu button
                  Positioned(
                    left: ResponsiveSize.getSpacing(context),
                    top: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        key: const Key('historyTab'),
                        onPressed: () => {Scaffold.of(context).openDrawer()},
                        icon: Icon(
                          Icons.menu,
                          color: CustomColors.secondary,
                          size: ResponsiveSize.getIconSize(context),
                        ),
                      ),
                    ),
                  ),
                  // Right side - Login/Logout
                  Positioned(
                    right: ResponsiveSize.getSpacing(context),
                    top: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child:
                      (jwt == null)
                          ? ElevatedButton(
                        key: const Key('goToLoginPageButton'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                        child: const Text(
                          'Aanmelden',
                          style: TextStyle(color: CustomColors.secondary),
                        ),
                      )
                          : isSmallScreen
                          ? IconButton(
                        onPressed: () {
                          showLogoutConfirmationDialog(context, () async { handleLogout(); });
                        },
                        icon: const Icon(Icons.logout, color: CustomColors.secondary),
                      )
                          : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureBuilder<String?>(
                            future: storage.read(key: 'username'),
                            builder: (context, usernameSnapshot) {
                              final username = usernameSnapshot.data ?? '';
                              return Text(
                                'Welkom ${username.length > 10 ? '${username.substring(0, 8)}...' : username}',
                                style: TextStyle(
                                  color: CustomColors.secondary,
                                  fontSize: ResponsiveSize.getFontSize(context, 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            key: const Key('logoutButton'),
                            onPressed: () {
                              showLogoutConfirmationDialog(
                                context,
                                    () async {
                                  handleLogout();
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: CustomColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

