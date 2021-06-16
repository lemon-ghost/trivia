import 'package:assignment/pages/Login.dart';
import 'package:assignment/pages/Registration.dart';
import 'package:assignment/pages/ForgotPass.dart';
import 'package:assignment/pages/Dashboard.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes ={
  Login.routeName: (BuildContext context) => Login(),
  Registration.routeName: (BuildContext context) => Registration(),
  ForgotPass.routeName: (BuildContext context) => ForgotPass(),
  Dashboard.routeName: (BuildContext context) => Dashboard()
};