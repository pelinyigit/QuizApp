import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';
import 'package:QuizApp/src/screens/Setup/signIn.dart';

import 'src/states/appstate.dart';
void main() => runApp(App());

class App extends StatelessWidget {
  final appState = AppState();

  @override
  Widget build(BuildContext context)=> 
     AppStateProvider<AppState>(
      appState: appState,
      child: MaterialPage(),
    );
  }


class MaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
          return MaterialApp(
              home: LoginPage(),
        
           );
  }

}
