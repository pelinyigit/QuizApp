import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../frontPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( ),
      backgroundColor: Colors.blueGrey,
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
              onPressed: signUp,
              color: Colors.lightGreen,
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Colors.grey),
            ),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        final FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.sendEmailVerification();
        //Display for user
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
      } catch (e) {
         print(e.message);
      }
     
    }
  }
}