import 'package:flutter/material.dart';
import 'package:to_do_app/auth/authform.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 20, 27),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 45, 133),
        title: Text('Authentification'),),
      body: AuthForm(),
      

    );
  }
}