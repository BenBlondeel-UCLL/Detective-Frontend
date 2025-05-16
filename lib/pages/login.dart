import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/header.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(title: "login"),
            Padding(
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
                        /// succes message
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              Text('succes', style: TextStyle(color: Colors.green),), 
                            ],
                          ),
                        ),
                        /// failed message
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel, color: Colors.red),
                              Text('failed', style: TextStyle(color: Colors.red),), 
                            ],
                          ),
                        ),
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
                                  child: ElevatedButton(onPressed: (){}, child: Text('sign in'))
                                ),

                                /// redirect to signup
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text('failed', style: TextStyle(color: Color(0xffE6F2F5)),),
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
            ),
        ],
      ),
    );
  }
}
