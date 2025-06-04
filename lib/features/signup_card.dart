import 'package:detective/api/http_client.dart';
import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/status_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class SignupCard extends StatefulWidget {
  const SignupCard({super.key});

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  String username = '';
  String email = '';
  String password = '';
  String passwordRetry = '';
  int? _status;
  String _statusText = '';

  final client = HttpClient();

  @override
  void initState() {
    super.initState();
    _statusText;
    _status;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(skipTraversal: true),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          _handleSignUp();
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
                        Text(
                          Texts.signupTitle,
                          style: TextStyle(color: CustomColors.secondary),
                        ),
                      ],
                    ),
                  ),

                  if (_status != null)
                    StatusMessage(state: _status == 200, text: _statusText),

                  Form(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          /// username
                          TextFormField(
                            key: const Key('signUpUsernameField'),
                            decoration: InputDecoration(
                              labelText: 'username',
                              labelStyle: const TextStyle(
                                color: CustomColors.secondary,
                              ),
                            ),
                            style: TextStyle(color: CustomColors.secondary),
                            onChanged: (value) => username = value,
                          ),

                          const SizedBox(height: Sizes.defaultSpace),

                          /// email
                          TextFormField(
                            key: const Key('signUpEmailField'),
                            decoration: InputDecoration(
                              labelText: 'email@gmail.com',
                              labelStyle: const TextStyle(
                                color: CustomColors.secondary,
                              ),
                            ),
                            style: TextStyle(color: CustomColors.secondary),
                            onChanged: (value) => email = value,
                          ),

                          const SizedBox(height: Sizes.defaultSpace),

                          ///password
                          TextFormField(
                            key: const Key('signUpPasswordField'),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'password',
                              labelStyle: const TextStyle(
                                color: CustomColors.secondary,
                              ),
                            ),
                            style: TextStyle(color: CustomColors.secondary),
                            onChanged: (value) => password = value,
                          ),

                          const SizedBox(height: Sizes.defaultSpace),

                          /// password retry
                          TextFormField(
                            key: const Key('signUpPasswordRepeatField'),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'repeat password',
                              labelStyle: const TextStyle(
                                color: CustomColors.secondary,
                              ),
                            ),
                            style: TextStyle(color: CustomColors.secondary),
                            onChanged: (value) => passwordRetry = value,
                          ),

                          const SizedBox(height: 20),

                          /// create account Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              key: const Key('signUpButton'),
                              onPressed: _handleSignUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                              child: Text(
                                'create account',
                                style: TextStyle(color: CustomColors.secondary),
                              ),
                            ),
                          ),

                          /// redirect to login
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: CustomColors.secondary,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    'sign in',
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

  bool _signupValidation({
    required String username,
    required String email,
    required String password,
    required String passwordRetry,
  }) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        _status = -1;
        _statusText = 'Invalid email format';
      });
      return false;
    }
    if (password != passwordRetry) {
      setState(() {
        _status = -1;
        _statusText = 'Passwords do not match';
      });
      return false;
    }
    return true;
  }

  void _handleSignUp() async {
    setState(() {
      _status = null;
      _statusText = '';
    });
    final validated = _signupValidation(
      username: username,
      email: email,
      password: password,
      passwordRetry: passwordRetry,
    );
    if (validated) {
      final response = await client.postSignUp(
        username: username,
        email: email,
        password: password,
      );
      setState(() {
        _status = response?.statusCode ?? -1;
        _statusText =
            _status == 200
                ? "Created Account"
                : response?.data['detail'] ??
                    response.statusMessage ??
                    'Unknown error';
      });
    }
    if (_status == 200) {
      await Future.delayed(Duration(milliseconds: 2000));
      Navigator.pushNamed(context, '/login');
    }
  }
}

