import 'package:flutter/material.dart';
import 'package:trivia/mixins/ValidationMixins.dart';
import 'package:trivia/pages/Login.dart';
import 'package:trivia/widgets/CustomTextFormField.dart';
import 'package:trivia/widgets/PredefinedTextFormField.dart';
import 'package:trivia/widgets/PrimaryButton.dart';

class ForgotPass extends StatefulWidget {
  static const String routeName = "forgotpass";
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> with ValidationMixin {
  TextEditingController emailTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Forgot Password",
          ),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: 50.0),
                CustomTextFormField(
                  labelText: "Email Address",
                  hintText: "Enter a valid email",
                  iconData: Icons.email,
                  textEditingController: emailTextController,
                  textInputType: TextInputType.emailAddress,
                  validate: validateEmail,
                ),
                SizedBox(height: 20.0),
                PrimaryButton(
                    iconData: Icons.email_outlined,
                    text: "Submit",
                    onPress: login)
              ],
            )));
  }

  void login() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login(fromForgot: true)));
    //Navigator.pushNamed(context, Login.routeName);
  }
}
