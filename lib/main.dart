import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/auth/authscreen.dart';
import 'package:to_do_app/screens/add_task.dart';
import 'package:to_do_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      home:StreamBuilder(stream:FirebaseAuth.instance.authStateChanges(),
      builder: (context, usersnapshot) {
        if(usersnapshot.hasData){
          return Home();
        }
        return AuthScreen();
      },
      ) ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFb5838d),
      ),
    );
  }
}