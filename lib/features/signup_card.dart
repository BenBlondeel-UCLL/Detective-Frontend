import 'package:critify/api/http_client.dart';
import 'package:critify/constants/padding_style.dart';
import 'package:critify/constants/sizes.dart';
import 'package:critify/constants/texts.dart';
import 'package:critify/features/status_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class SignupCard extends StatefulWidget {
  final HttpClient? httpClient;
  const SignupCard({super.key, this.httpClient});

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

  late final HttpClient client;

  @override
  void initState() {
    super.initState();
    client = widget.httpClient ?? HttpClient();
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
                              labelText: 'gebruikersnaam',
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
                              labelText: 'wachtwoord',
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
                              labelText: 'herhaal wachtwoord',
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
                                'maak account',
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
                                    'meld je aan',
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
    if (username == ''){
      setState(() {
        _status = -1;
        _statusText = 'Een gebruikersnaam moet minstens 1 karakter bevatten';
      });
      return false;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        _status = -1;
        _statusText = 'Ongeldig email formaat';
      });
      return false;
    }
    if (password.length < 8){
      setState(() {
        _status = -1;
        _statusText = 'Wachtwoord moet minstens 8 karakters hebben';
      });
      return false;
    }
    if (password != passwordRetry) {
      setState(() {
        _status = -1;
        _statusText = 'Wachtwoorden zijn niet hetzelfde';
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
                ? "Account aangemaakt"
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

