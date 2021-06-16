import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  static const String routeName = "forgotpass";
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Forgot Password",
            ),
      ),
      body: Container(
        child: Text("Hey, this is the dashboard"),
      ),
      
    );
  }
}