import 'package:trivia/pages/Login.dart';
import 'package:trivia/pages/Registration.dart';
import 'package:trivia/pages/ForgotPass.dart';
import 'package:trivia/pages/Dashboard.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes ={
  Login.routeName: (BuildContext context) => Login(),
  Registration.routeName: (BuildContext context) => Registration(),
  ForgotPass.routeName: (BuildContext context) => ForgotPass(),
  Dashboard.routeName: (BuildContext context) => Dashboard()
};