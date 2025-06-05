import 'dart:convert';

import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/status_message.dart';
import 'package:flutter/material.dart';
import 'package:detective/api/http_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  bool _isObscured = true;
  String email = '';
  String password = '';
  int? _status;

  final client = HttpClient();

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _isObscured = true;
    _status;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(skipTraversal: true),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          _handleSignIn();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: Sizes.appBarHeight),
        child: SizedBox(
          width: 550,
          child: SingleChildScrollView(
            child: Container(
              padding: PaddingStyle.paddingWithAppBarHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusBig),
                color: CustomColors.primary,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Image(
                          width: 100,
                          height: 100,
                          image: AssetImage('assets/images/logo_1.png'),
                        ),
                        const SizedBox(height: Sizes.spaceBetweenSections),
                        Text(
                          Texts.loginTitle,
                          style: TextStyle(color: CustomColors.secondary),
                        ),
                      ],
                    ),
                  ),

                  (_status != null
                      ? (_status == 200
                          ? StatusMessage(
                            state: true,
                            text: 'succesfully logged in',
                          )
                          : StatusMessage(
                            state: false,
                            text: 'failed to log in',
                          ))
                      : SizedBox()),

                  Form(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          ///email
                          TextFormField(
                            key: const Key('loginEmailField'),
                            decoration: InputDecoration(
                              labelText: 'email@gmail.com',
                              labelStyle: const TextStyle(
                                color: CustomColors.secondary,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: CustomColors.secondary,
                              ),
                            ),
                            style: TextStyle(color: CustomColors.secondary),
                            onChanged: (value) => email = value,
                          ),
                          const SizedBox(height: 20),

                          ///password
                          TextFormField(
                            key: const Key('loginPasswordField'),
                            obscureText: _isObscured,
                            onChanged: (value) => password = value,
                            decoration: InputDecoration(
                              labelText: 'password',
                              labelStyle: const TextStyle(
                                color: CustomColors.secondary,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: CustomColors.secondary,
                              ),
                              suffixIcon: IconButton(
                                icon:
                                    _isObscured
                                        ? const Icon(
                                          Icons.visibility,
                                          color: CustomColors.secondary,
                                        )
                                        : const Icon(
                                          Icons.visibility_off,
                                          color: CustomColors.secondary,
                                        ),
                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: CustomColors.secondary),
                          ),

                          const SizedBox(height: 20),

                          /// Sign In Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              key: const Key('loginButton'),
                              onPressed: _handleSignIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                              child: Text(
                                'Sign in',
                                style: TextStyle(color: CustomColors.secondary),
                              ),
                            ),
                          ),

                          /// redirect to signup
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  'Don\'t have an account yet?',
                                  style: TextStyle(
                                    color: CustomColors.secondary,
                                  ),
                                ),
                                TextButton(
                                  key: const Key('goToSignUpPageButton'),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    'sign up',
                                    style: TextStyle(
                                      color: CustomColors.secondary,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignIn() async {
    setState(() {
      _status = null;
    });
    final response = await client.postLogin(email: email, password: password);
    setState(() {
      _status = response?.statusCode ?? -1;
    });
    if (_status == 200) {
      final response = await client.getHistory();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('history', jsonEncode(response.data));
      await Future.delayed(Duration(milliseconds: 2000));
      Navigator.pushNamed(context, '/');
    }
  }
}
