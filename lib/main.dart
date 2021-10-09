import 'package:authapp/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {

  // use for firebase
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){

        // use for checking error      
        if(snapshot.hasError){
          print('Something went wrong');
        }
        if(snapshot.connectionState == ConnectionState.waiting ){
          return Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          debugShowCheckedModeBanner: false,


          home: LoginScreen(),
    );
      }
    );
  }
}
