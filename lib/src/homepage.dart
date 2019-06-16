import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'states/appstate.dart';
import 'states/models.dart';
import 'screens/frontPage.dart';
import 'screens/quizPage.dart';
import 'screens/scorePage.dart';
/// Styles
const textStyle = TextStyle(color: Colors.blue);
const iconColor = Colors.blueGrey;

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  Widget _switchTab(AppTab tab, AppState appState) {
    switch (tab) {
      case AppTab.main:
        return MainPage();
        break;
      case AppTab.trivia:
        return TriviaPage();
        break;
      case AppTab.summary:
        return SummaryPage(stats: appState.triviaBloc.stats);
        break;
      default:
        return MainPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return ValueBuilder(
      streamed: appState.tabController,
      builder: (context, snapshot) => Scaffold(
            appBar: snapshot.data != AppTab.main ? null : AppBar(),
            body: _switchTab(snapshot.data, appState),
          ),
    );
  }
}

