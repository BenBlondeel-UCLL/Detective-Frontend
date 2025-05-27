import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/status_message.dart';
import 'package:flutter/material.dart';
import 'package:detective/api/http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginCard extends StatefulWidget{
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
                      const Image(width: 100, height: 100, image: AssetImage('assets/images/logo_1.png')),
                      const SizedBox(height: Sizes.spaceBetweenSections,),
                      Text(
                        Texts.loginTitle, 
                        style: TextStyle(
                          color: Color(0xffE6F2F5),
                        ),
                      ),
                    ],
                  ),
                ),
                
                (_status != null
                  ? (_status == 200
                      ? StatusMessage(state: true, text: 'succesfully logged in')
                      : StatusMessage(state: false, text: 'failed to log in'))
                  : SizedBox()),
                
                Form(
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        ///email
                        TextFormField(
                          decoration: InputDecoration(
                          labelText: 'email@gmail.com',
                          labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                          prefixIcon: const Icon(Icons.person, color: Color(0xffE6F2F5),),
                          ),
                          style: TextStyle(color: Color(0xffE6F2F5),),
                          onChanged: (value) => email = value,
                        ),
                        const SizedBox(height: 20),
      
                        ///password
                        TextFormField(
                          obscureText: _isObscured,
                          onChanged: (value) => password = value,
                          decoration: InputDecoration(
                            labelText: 'password',
                            labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                            prefixIcon: const Icon(Icons.lock, color: Color(0xffE6F2F5),),
                            suffixIcon: IconButton(
                              icon: _isObscured ? const Icon(Icons.visibility, color: Color(0xffE6F2F5),) : const Icon(Icons.visibility_off, color: Color(0xffE6F2F5),),
                              onPressed: () {
                                setState(() {
                                  _isObscured =!_isObscured;
                                });
                              }) 
                          ),
                          style: TextStyle(color: Color(0xffE6F2F5),),
                        ),
      
                        const SizedBox(height: 20),
      
                        /// Sign In Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _status = null;
                              });
                              final response = await client.postLogin(email: email, password: password);
                              setState(() {
                                _status = response?.statusCode ?? -1;
                              });
                              if (_status == 200) {
                                await client.getHistory();
                                await Future.delayed(Duration(milliseconds: 2000));
                                Navigator.pushNamed(context, '/');
                              }
                              // print('storage: ${storage.read(key: 'jwt', options: <String, String>{})}');                              
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff00a2d4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            child: Text('Sign in', style: TextStyle(color: Color(0xffe6f2f5))),
                          ),
                        ),

                        /// redirect to signup
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text('Don\'t have an account yet?', style: TextStyle(color: Color(0xffE6F2F5)),),
                              TextButton(onPressed: (){ Navigator.pushNamed(context, '/signup'); }, child: Text('sign up', style: TextStyle(color: Color(0xffE6F2F5)), ))
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