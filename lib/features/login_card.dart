import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/status_message.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget{
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();  
}

class _LoginCardState extends State<LoginCard> {

  bool _isObscured = true;
  Object _userInfo = {};

  @override
  void initState() {
    super.initState();
    _isObscured = true;
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
                
                StatusMessage(state: true, text: 'succesfully logged in'),

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
                          onChanged: (value) => _userInfo = value,
                        ),
                        const SizedBox(height: 20),
      
                        ///password
                        TextFormField(
                          obscureText: _isObscured,
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
                            onPressed: (){
                              print(_userInfo);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff00a2d4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            child: Text('log in', style: TextStyle(color: Color(0xffe6f2f5))),
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