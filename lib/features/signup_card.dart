import 'package:detective/constants/padding_style.dart';
import 'package:detective/constants/sizes.dart';
import 'package:detective/constants/texts.dart';
import 'package:detective/features/status_message.dart';
import 'package:flutter/material.dart';

class SignupCard extends StatelessWidget {
  const SignupCard({super.key});

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
                
                StatusMessage(state: true, text: 'succesfully signed up'),

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
                              backgroundColor: Color(0xff00a2d4),
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