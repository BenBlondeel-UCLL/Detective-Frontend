import 'package:detective/api/http_client.dart';
import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/status_message.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.appBarHeight),
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: PaddingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.borderRadiusBig),
              color: Color(0xff001f34),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                      children: [
                      Text(
                        Texts.signupTitle, 
                        style: TextStyle(
                          color: Color(0xffE6F2F5),
                        ),
                      ),
                    ],
                  ),
                ),
                
                if (_status != null)
                  StatusMessage(state: _status == 200, text: _statusText),

                Form(
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        /// username
                        TextFormField(
                          decoration: InputDecoration(
                          labelText: 'username',
                          labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                          ),
                          style: TextStyle(color: Color(0xffE6F2F5),),
                          onChanged: (value) => username = value
                        ),

                        const SizedBox(height: Sizes.defaultSpace),
      
                        /// email
                        TextFormField(
                          decoration: InputDecoration(
                          labelText: 'email@gmail.com',
                          labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                          ),
                          style: TextStyle(color: Color(0xffE6F2F5),),
                          onChanged: (value) => email = value
                        ),

                        const SizedBox(height: Sizes.defaultSpace),

                        ///password
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'password',
                            labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                          ),
                          style: TextStyle(color: Color(0xffE6F2F5),),
                          onChanged: (value) => password = value
                        ),

                        const SizedBox(height: Sizes.defaultSpace),

                        /// password retry
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'repeat password',
                            labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                          ),
                          style: TextStyle(color: Color(0xffE6F2F5),),
                          onChanged: (value) => passwordRetry = value
                        ),
      
                        const SizedBox(height: 20),
      
                        /// create account Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _status = null;
                                _statusText = '';
                              });
                              final response = await client.postSignUp(username: username, email: email, password: password, passwordRetry: passwordRetry);
                              setState(() {
                                _status = response?.statusCode ?? -1;
                                _statusText = response?.statusMessage;
                              });
                              if (_status == 200) {
                                await Future.delayed(Duration(milliseconds: 2000));
                                Navigator.pushNamed(context, '/');
                              }
                            }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff00a2d4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            child: Text('create account', style: TextStyle(color: Color(0xffe6f2f5))),
                          ),
                        ),

                        /// redirect to login
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text('Already have an account?', style: TextStyle(color: Color(0xffE6F2F5)),),
                              TextButton(onPressed: (){ Navigator.pushNamed(context, '/login'); }, child: Text('sign in', style: TextStyle(color: Color(0xffE6F2F5)), ))
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
    );
  }
}