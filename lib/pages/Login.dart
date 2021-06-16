import 'package:trivia/mixins/ValidationMixins.dart';
import 'package:trivia/pages/Dashboard.dart';
import 'package:trivia/pages/Registration.dart';
import 'package:trivia/widgets/CustomTextFormField.dart';
import 'package:trivia/widgets/PasswordField.dart';
import 'package:trivia/widgets/PrimaryButton.dart';
import 'package:trivia/widgets/SecondaryButton.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with ValidationMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal:15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children:[
                    SizedBox(
                      height:20.0,
                    ),
                    CustomTextFormField(
                      labelText: "Email Address", 
                      hintText: "Enter a valid email", 
                      iconData: Icons.email, 
                      textEditingController: emailTextController,
                      textInputType: TextInputType.emailAddress,
                      validate: validateEmail,
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    PasswordField(
                      labelText: "Password", 
                      hintText: "Enter your password",
                      textEditingController: passwordTextController,
                      obscureText: obscureText, 
                      onTap: setPasswordVisibility,
                      validate: validatePassword,
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    PrimaryButton(
                      text: "Login", 
                      iconData: Icons.login, 
                      onPress: login
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SecondaryButton(
                          text: "New User? Register", 
                          onPress:() {
                            navigateToRegistration(context);
                          }
                        ),
                        SecondaryButton(text: "Forgot Password?", onPress: (){}),
                      ],
                    )
                  ]
                ),
              ),
            ),
          )
        ),
      ));
  }

  void login(){
    if(formKey.currentState.validate()){
      Navigator.pushNamed(context, Dashboard.routeName);
    }else{
      print("Invalid input");
    }

  }

  void setPasswordVisibility(){
    setState(() {
      obscureText = !obscureText;
    });
  }

  void navigateToRegistration(BuildContext context){
    Navigator.pushNamed(context, Registration.routeName);
  }

}