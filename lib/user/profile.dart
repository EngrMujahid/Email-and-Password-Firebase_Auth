import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;

  // Email verfication code

  verfiyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been Sent');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Verification Email has been Sent',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          //For Text
          Text(
            'User ID: fgfg2342',
            style: TextStyle(fontSize: 18.0),
          ),

          // Field For Row
          Row(
            children: [
              Text(
                'Email: user@gmail.com',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),

            
          //TextButton for verfiy Email
          TextButton(
            onPressed: () {
              verfiyEmail();
            },
            child: Text('Verify Email'),
          ),

          //For Text
          Text(
            'Created: 21/02/2025',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
