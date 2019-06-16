import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:QuizApp/src/screens/Setup/signUp.dart';

import '../../homepage.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('QuizApp'),
        ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email'
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (input) {
                  if (input.length < 6 ) {
                    return 'Your password needs to be at least 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password'
                  ),
                  obscureText: true,
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal:155.0),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
             // side: BorderSide(color: Colors.white),
            ),
              onPressed: signIn,
              child: const Text('Login'),
            ),
            RaisedButton(
              color: Colors.green,
              padding:const EdgeInsets.symmetric(horizontal: 150.0),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            //  side: BorderSide(color: Colors.white),
            ),
              onPressed: navigateToSignUp,
              child:const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        final FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));
      } catch (e) {
         print(e.message);
      }
     
    }
  }
    void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
