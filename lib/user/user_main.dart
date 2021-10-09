import 'package:authapp/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'change_password.dart';
import 'dashboard.dart';
import 'profile.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;

  // make a list of static widgets

  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    ChangePassword(),
  ];

  // create tap on which the widgets

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text('Welcome to Here'),

            // Field for Button   

            ElevatedButton(
              onPressed: () async =>{
                await FirebaseAuth.instance.signOut(),
                Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                     ),
                      (route) => false)
              },
               child: Text('Logout'),
               style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
               ),
          ],
        ),
      ),

      body: _widgetOptions.elementAt(_selectedIndex),

      // use for making BottomNavigationBarItem

      bottomNavigationBar: BottomNavigationBar(
        items: const < BottomNavigationBarItem >[

          // bottomNavigationBarItem for Dashboard

          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label: 'Dashboard',
             ),

          // bottomNavigationBarItem for Profile

          BottomNavigationBarItem(
            icon:Icon(Icons.person),
            label: 'Profile',
             ),

          // bottomNavigationBarItem for Change Password

          BottomNavigationBarItem(
            icon:Icon(Icons.settings),
            label: 'Changr password',
             ),  

        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),



    );
  }
}
