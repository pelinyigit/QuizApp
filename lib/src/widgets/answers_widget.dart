import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../CSS.dart';
import '../blocs/trivia_bloc.dart';
import '../states/models.dart';
import '../states/question.dart';

const questionLeadings = ['A', 'B', 'C', 'D'];
const boxHeight = 72.0;

class AnswersWidget extends StatefulWidget {
  const AnswersWidget(
      {this.bloc, this.question, this.answerAnimation, this.isTriviaEnd});

  final Question question;
  final TriviaBloc bloc;
  final AnswerAnimation answerAnimation;
  final bool isTriviaEnd;

  @override
  _AnswersWidgetState createState() => _AnswersWidgetState();
}

class _AnswersWidgetState extends State<AnswersWidget>
    with TickerProviderStateMixin {
  bool isCorrect = false;

  final Map<int, Animation<double>> animations = {};
  AnimationController controller;
  Animation<Color> colorAnimation;
  Color color;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1250), vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _checkCorrectAnswer() {
    isCorrect = widget.question.correctAnswerIndex ==
            widget.answerAnimation.chosenAnswerIndex
        ? true
        : false;
  }

  Future _initAnimation() async {
    for (int i = 0; i < 4; i++) {
      animations[i] = Tween<double>(begin: boxHeight * i, end: boxHeight * i)
          .animate(controller);
    }

    colorAnimation = ColorTween(
      begin: answerBoxColor,
      end: answerBoxColor,
    ).animate(controller);
  }

  Future _startAnimation() async {
    _checkCorrectAnswer();

    final index = widget.answerAnimation.chosenAnswerIndex;

    for (int i = 0; i < 4; i++) {
      if (i != index) {
        animations[i] =
            Tween<double>(begin: boxHeight * i, end: boxHeight * index)
                .animate(controller)
                  ..addListener(() {
                    setState(() {});
                    if (controller.status == AnimationStatus.completed) {
                      widget.bloc.onChosenAnwserAnimationEnd();
                      controller.reset();
                    }
                  });
      }
    }

    var newColor;

    if (isCorrect) {
      newColor = Colors.green;
    } else {
      newColor = Colors.red;
    }

    colorAnimation = ColorTween(
      begin: answerBoxColor,
      end: newColor,
    ).animate(controller);

    await controller.forward();
  }

  @override
  void didUpdateWidget(AnswersWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future _playAnimation(String answer) async {
    widget.bloc.onChosenAnswer(answer);
    await _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = widget.question.answers.map((answer) {
      final index = widget.question.answers.indexOf(answer);

      return Positioned(
        top:  (index != widget.answerAnimation.chosenAnswerIndex
            ? animations[index].value
            : boxHeight * index),
 
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: GestureDetector(
              child: FadeInWidget(
                duration: 750,
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: (index == widget.answerAnimation.chosenAnswerIndex)
                              ? colorAnimation.value
                              : const Color(0xff283593),
                         ),
                      child:Text(answer, style: answersStyle),  
                      padding: const EdgeInsets.fromLTRB(160, 25, 200, 30),  
                    ),
                  ],
                ),
              ),
              onTap: () {
                if (!widget.isTriviaEnd) {
                  _playAnimation(answer);
                }
              }),
        ),
      );
    }).toList();
    final last = widgets.last;
    final chosen = widgets[widget.answerAnimation.chosenAnswerIndex];
    final chosenIndex = widgets.indexOf(chosen);

    widgets.last = chosen;
    widgets[chosenIndex] = last;

    return Container(
      child: Stack(
        children: widgets,
      ),
    );
  }
}
