import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../CSS.dart';
import '../states/appstate.dart';
import '../states/models.dart';
import '../states/scoringTable.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({this.stats});

  final TriviaStats stats;

  List<Widget> _buildQuestions() {
  
    final widgets = List<Widget>()
      ..add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 285),
          child: Container(
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                'SCORE: ${stats.score}',
                style: summaryScoreStyle,
              ),
            ),
          ),
        ),
      );

    
    return widgets;
     
  }
 
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    final List<Widget> widgets = _buildQuestions()
     
      ..add(Container(
        color: Colors.blueGrey,
        child: IconButton(
      padding: const EdgeInsets.fromLTRB(0, 0, 350, 0),
          icon: const Icon(Icons.keyboard_arrow_left),
          color: Colors.black,
          iconSize: 60.0,
          onPressed: () => appState.tabController.value = AppTab.main,
        ),
      ));

    return Container(
      color: Colors.blueGrey,
      child: FadeInWidget(
        duration: 750,
        child: ListView(
          shrinkWrap: true,
          children: widgets,
        ),
      ),
    );
  }
}
