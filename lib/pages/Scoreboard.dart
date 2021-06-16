import 'package:flutter/material.dart';
import 'package:trivia/utils/Constants.dart';

class Scoreboard extends StatefulWidget {
  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBackgroundColor,
      body:Text("Scoreboard")
    );
  }
}