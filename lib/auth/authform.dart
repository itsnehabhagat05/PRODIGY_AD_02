import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthForm> {
  //........................................................
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';

  bool isLoginPage = false;
  //........................................................

  startauthentification() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(validity){
      _formkey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential;
    try{
      if(isLoginPage){
        userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      }
      else{
        userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username' : username,
          'email' : email,
        });
      }
    }
    catch(err){
      print(err);

    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(children: [
        Container(
          padding: EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Form(
            
            key: _formkey,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Container(height: 300,
                width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/logg.png",fit:BoxFit.cover,),),
                
                SizedBox(
                  height: 20.0,
                ),
                if(!isLoginPage)
                  TextFormField(
                  //cursorColor: Colors.black, 
                  
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('Username'),
                  
                  validator: (value) {
                    if(value!.isEmpty ){
                      return 'Incorrect Username';

                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.person,size: 25,color: Colors.white,),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      borderSide: new BorderSide(),
                    ),
                    labelText: "Enter Username",
                    labelStyle: GoogleFonts.roboto()),
                    
                  ),
                SizedBox(height: 10),
              TextFormField(style:TextStyle(color: Colors.white,),
          
                keyboardType: TextInputType.emailAddress,
                key: ValueKey('email'),
                validator: (value) {
                  if(value!.isEmpty || !value.contains('@')){
                    return 'Incorrect Email';

                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                  
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.email,size: 25,color: Colors.white,),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide: new BorderSide()
                  ),
                  labelText: "Enter Email",
                  labelStyle:GoogleFonts.roboto()),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                key: ValueKey('password'),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Incorrect Password';

                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                  
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.lock,size: 25,color: Colors.white,),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide: new BorderSide()
                  ),
                  labelText: "Enter Password",
                  labelStyle: GoogleFonts.roboto()),
                  
                ),  
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    child: isLoginPage?Text('Log In',style: GoogleFonts.roboto(fontSize: 16),): Text('Sign Up',style: GoogleFonts.roboto(fontSize:16 ),),
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFf72585),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: () {
                      startauthentification();
                    },      
                  ),
                ),  
                SizedBox(height: 5,),
                Container(
                  child: TextButton(onPressed: () {
                    setState(() {
                      isLoginPage =!isLoginPage;
                    });
                  },
                  child: isLoginPage
                  ?Text(
                    'Not a Member ?',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white),
                  )
                  : Text(
                    'Already a Member ?',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.grey),),)

              ),   
              ],
              
           ) ),)
      ],),

    );
  }
}