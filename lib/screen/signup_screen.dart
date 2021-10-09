import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forget_password.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var confirmpassword = '';

  // controller used for geting value which we type in field

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  //Method of registration

  registration() async {
    if (password == confirmpassword) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // section for Dialog messages

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Registration is Successfully',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );

        // Navigate to login page

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('Password is too weak');
        } else if (e.code == 'email-already-in-use') {
          print('Account already in use');
        }
      }
    } else {
      print('password and confirm password do not match');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Signup'),
      ),
      body: Form(
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

                // textform field for password

                child: TextFormField(
                  autofocus: false,
                  obscureText: true,

                  // textfield decoration for password

                  decoration: InputDecoration(
                    labelText: 'Password:',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(fontSize: 15.0, color: Colors.redAccent),
                  ),
                  controller: passwordController,

                  // validation for password
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password:';
                    }
                    return null;
                  },
                ),
              ),

              // container for confirmpassword

              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),

                // textform field for password

                child: TextFormField(
                  autofocus: false,
                  obscureText: true,

                  // textfield decoration for confirm password

                  decoration: InputDecoration(
                    labelText: 'Confirm Password:',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(fontSize: 15.0, color: Colors.redAccent),
                  ),
                  controller: confirmpasswordController,

                  // validation for confirm password
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Confirm Password:';
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
                            confirmpassword = confirmpasswordController.text;
                          });

                          // call a method by which we send data to firebase

                          registration();
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),

                    // field for textbutton
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          ),
                        )
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
                    Text('Already have an Account?'),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => LoginScreen(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                            (route) => false)
                      },
                      child: Text(
                        'Login',
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
