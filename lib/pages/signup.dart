import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/header.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(title: "signup"),
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
                              Text(
                                Texts.signupTitle, 
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
                                /// username
                                TextFormField(
                                  decoration: InputDecoration(
                                  labelText: 'username',
                                  labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                                  ),
                                  style: TextStyle(color: Color(0xffE6F2F5),),
                                ),

                                const SizedBox(height: Sizes.defaultSpace),
              
                                /// email
                                TextFormField(
                                  decoration: InputDecoration(
                                  labelText: 'email@gmail.com',
                                  labelStyle: const TextStyle(color: Color(0xffE6F2F5)),
                                  ),
                                  style: TextStyle(color: Color(0xffE6F2F5),),
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
                                ),
              
                                const SizedBox(height: 20),
              
                                /// Sign In Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: (){}, 
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                    ),
                                    child: Text('sign in'), )
                                ),

                                /// redirect to login
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text('failed', style: TextStyle(color: Color(0xffE6F2F5)),),
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
            ),
        ],
      ),
    );
  }
}
