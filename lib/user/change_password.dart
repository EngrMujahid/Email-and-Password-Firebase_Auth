import 'package:authapp/screen/login_screen.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  // declear variable
  var newPassword = '';

  // create controller for password
  final newPasswordController = TextEditingController();

  // code for dispose controller
  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  // change password methods
  changePassword() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),

        //ListView
        child: ListView(
          children: [
            // container field
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),

              // TextField
              child: TextFormField(
                autofocus: false,
                obscureText: true,

                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter New Password',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),

                controller: newPasswordController,

                // validation methods
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
              ),
            ),

            //Eleveated button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    newPassword = newPasswordController.text;
                  });
                  //changepassword function call
                  ChangePassword();
                }
              },

              // text field
              child: Text(
                'Change Password',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
