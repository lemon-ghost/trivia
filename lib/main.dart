import 'package:trivia/pages/Login.dart';
import 'package:trivia/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      //backgroundColor: Color.fromRGBO(251, 232, 166, 1),
      primaryColor: Color.fromRGBO(48, 60, 108, 1),
      accentColor: Color.fromRGBO(210, 253, 255, 1),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold
        ),
        headline6: TextStyle(
          fontSize: 36.0,
          fontStyle: FontStyle.italic
        ),
        bodyText2: TextStyle(
          fontSize: 18.0
        )
      ),
    ),
    routes: routes,
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}
