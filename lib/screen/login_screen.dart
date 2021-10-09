import 'package:authapp/user/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forget_password.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';

  // controller used for geting value which we type in field

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //userLogin Auth  method 

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserMain(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Not found this user');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Not found this user',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );

      }
      else if (e.code == 'wrong-password') {
        print('Your Password is incorrect');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Your Password is incorrect',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );

      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
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
                    errorStyle:
                        TextStyle(fontSize: 15.0, color: Colors.redAccent),
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

              // container for password

              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),

                // textform field for email

                child: TextFormField(
                  autofocus: false,
                  obscureText: true,

                  // textfield decoration for email

                  decoration: InputDecoration(
                    labelText: 'Password:',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(fontSize: 15.0, color: Colors.redAccent),
                  ),
                  controller: passwordController,

                  // validation for email
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password:';
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
                            password = passwordController.text;
                          });
                          userLogin();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),

                    // field for textbutton
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => ForgetPassword(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                            (route) => false)
                      },
                      child: Text(
                        'Forget Password?',
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
                              pageBuilder: (context, a, b) => SignupScreen(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                            (route) => false)
                      },
                      child: Text(
                        'Sign Up',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
