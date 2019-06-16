import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../CSS.dart';
import '../states/appstate.dart';
import '../states/models.dart';
import '../states/question.dart';
import '../widgets/answers_widget.dart';
import '../widgets/question_widget.dart';

class TriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).triviaBloc;

    return ValueBuilder<TriviaState>(
        streamed: bloc.triviaState,
        builder: (context, snapshotTrivia) {
          return ValueBuilder<Question>(
              streamed: bloc.currentQuestion,
              builder: (context, snapshotQuestion) {
                return Container(
                  color: Colors.blueGrey,
                  child: TriviaMain(
                      triviaState: snapshotTrivia.data,
                      question: snapshotQuestion.data),
                );
              });
        });
  }
}

class TriviaMain extends StatelessWidget {
  const TriviaMain({this.triviaState, this.question});

  final TriviaState triviaState;
  final Question question;

  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).triviaBloc;
    final appState = AppStateProvider.of<AppState>(context);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: const Color(0xff286b93),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            boxShadow: [
              BoxShadow(color: Colors.blue, blurRadius: 3.0, spreadRadius: 1.5),
            ],
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                    iconSize: 30.0,
                    onPressed: () => appState.tabController.value = AppTab.main,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Corrects: ${bloc.stats.corrects.length}',
                    style: correctsHeaderStyle,
                  ),
                  Text(
                    'Wrongs: ${bloc.stats.wrongs.length}',
                    style: wrongsHeaderStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
        Container(
           color: Colors.blueGrey,
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 20, 30, 0) ,
          color: Colors.blueGrey,
          child: QuestionWidget(
            bloc: bloc,
            question: question,
          ),
        ),
        Container(
           color: Colors.blueGrey,
          height: 250,
        ),
        Expanded(
          flex: 1,
          child: ValueBuilder<AnswerAnimation>(
              streamed: bloc.answersAnimation,
              builder: (context, snapshot) {
                return Container(
                   color: Colors.blueGrey,
                     padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: AnswersWidget(
                      bloc: bloc,
                      question: question,
                      answerAnimation: snapshot.data,
                      isTriviaEnd: triviaState.isTriviaEnd,
                    ));
              }),
        ),
        ValueBuilder<int>(
            streamed: bloc.currentTime,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Container(
                     color: Colors.blueGrey,
                    height: 20,
                    child: Text(
                      'Time left: ${((bloc.countdown - snapshot.data) / 1000)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              );
            }),  
      ],
    );
  }
}
