import 'package:trivia/mixins/ValidationMixins.dart';
import 'package:trivia/pages/Dashboard.dart';
import 'package:trivia/pages/ForgotPass.dart';
import 'package:trivia/pages/Registration.dart';
import 'package:trivia/widgets/CustomTextFormField.dart';
import 'package:trivia/widgets/PasswordField.dart';
import 'package:trivia/widgets/PrimaryButton.dart';
import 'package:trivia/widgets/SecondaryButton.dart';
import 'package:trivia/utils/DummyData.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";
  bool fromForgot = false;

  Login({this.fromForgot});
  @override
  _LoginState createState() => _LoginState(fromForgot: this.fromForgot);
}

class _LoginState extends State<Login> with ValidationMixin {
  bool fromForgot = false;

  _LoginState({this.fromForgot});

  DummyData temp = new DummyData();

  Map user;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool obscureText = true;
  bool visibility = false;
  bool bisible = false;
  String _text = "holder";

  @override
    void initState() {
      super.initState();
      fromFor();
      setUser();
  }

  void fromFor(){
    var x = (fromForgot==true)? true:false;
    setState(() {
      bisible=x;
    });
  }

  void setUser(){
    var x = temp.defaultUser();
    setState(() {
      user=x;
    });
  }
    
    

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(children: [
                  SizedBox(
                    height: 20.0,
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
                    height: 20.0,
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
                    height: 20.0,
                  ),
                  Visibility(
                      visible: visibility,
                      child: Center(
                          child: Text(
                        _text,
                        style: TextStyle(fontSize: 10.0, color: Colors.red),
                      ))),
                  SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                      text: "Login", iconData: Icons.login, onPress: login),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SecondaryButton(
                          text: "New User? Register",
                          onPress: () {
                            navigateToRegistration(context);
                          }),
                      SecondaryButton(text: "Forgot Password?", onPress: forgot),
                    ],
                  ),
                  Visibility(
                      visible: bisible,
                      child: Center(
                          child: Text(
                        "Your request has been sent",
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        )
                      )
                    ),
                ]),
              ),
            ),
          )),
    ));
  }

  void forgot(){
    Navigator.pushNamed(context, ForgotPass.routeName);
  }

  void login() {
    Map value = {
      "email": emailTextController.text,
      "password": passwordTextController.text,
    };
    if(bisible==true)
    setState(() { 
      bisible=false;
    });

    if (formKey.currentState.validate()) {
      if (validateUser(value) == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard(user: this.user)));
        //Navigator.pushNamed(context, Dashboard.routeName, arguments: {user});
        visibility = false;
      } else {
        print("Invalid input");
        setState(() {
          print("value $value");
          _text = (validateUser(value));
        });
        visibility = true;
      }
    }
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void navigateToRegistration(BuildContext context) {
    Navigator.pushNamed(context, Registration.routeName);
  }
}
