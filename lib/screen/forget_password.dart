import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  var email = '';

  // controller used for geting value which we type in field

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  //restpassword method

  restpassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // section for Dialog messages

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Password Reset Email has been sent',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found');
        // section for Dialog messages

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'User not found',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest Password'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              'Reset Link will be sent to your Email id !',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: ListView(
                  children: [
                    // container for email

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),

                      // textform field for email

                      child: TextFormField(
                        autofocus: false,
                        // textfield decoration for email

                        decoration: InputDecoration(
                          labelText: 'Email:',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                              fontSize: 15.0, color: Colors.redAccent),
                        ),
                        controller: emailController,

                        // validation for email
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email:';
                          } else if (!value.contains("@")) {
                            return 'Please Enter Valid Email :';
                          }
                          return null;
                        },
                      ),
                    ),
                    // container for button
                    Container(
                      margin: EdgeInsets.only(left: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                });

                                // restpassword method call

                                restpassword();
                              }
                            },
                            child: Text(
                              'Send Email',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),

                          // field for textbutton
                          TextButton(
                            onPressed: () => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) =>
                                        LoginScreen(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                  (route) => false)
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Donot have an Account?'),
                          TextButton(
                            onPressed: () => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) =>
                                        SignupScreen(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                  (route) => false)
                            },
                            child: Text(
                              'Sign up',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
