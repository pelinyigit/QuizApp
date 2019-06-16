import 'package:flutter/material.dart';

//
// ** Trivia page **
//
const textColor = Colors.white;

const scoreHeaderStyle = TextStyle(
  letterSpacing: 2.0,
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  shadows: [
    Shadow(
      blurRadius: 2.0,
      color: Colors.red,
    ),
  ],
);
const questionsHeaderStyle = TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic);

const answerBoxColor = Color(0xff5495c1);

const questionCircleAvatarBackground = Color(0xff35b333);

const questionCircleAvatarRadius = 14.0;

const answersLeadingStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700);

const answersStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);

//
// ** Summary page **
//
const dividerHeight = 12.0;
const dividerColor = Colors.blueGrey;

const circleAvatarRadius = 12.0;
const circleAvatarBackground = Color(0xff4a5580);

const summaryScoreStyle = TextStyle(
    color: Colors.grey,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic);

const questionHeaderStyle = TextStyle(
    color: Colors.white54,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic);

const questionStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const correctsHeaderStyle = TextStyle(
  color: Colors.greenAccent,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const wrongsHeaderStyle = TextStyle(
  color: Colors.redAccent,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const notAnsweredHeaderStyle = TextStyle(
  color: Color(0xffe1e1e1),
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const correctAnswerStyle =
    TextStyle(color: Colors.green, fontWeight: FontWeight.w600);


const notChosenStyle = TextStyle(
    color: Color(0xffe1e1e1),
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic);
