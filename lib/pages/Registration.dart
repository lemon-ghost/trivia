import 'package:trivia/mixins/ValidationMixins.dart';
import 'package:trivia/pages/Dashboard.dart';
import 'package:trivia/pages/Login.dart';
import 'package:trivia/widgets/CustomTextFormField.dart';
import 'package:trivia/widgets/PasswordField.dart';
//import 'package:assignment/widgets/PredefinedTextFormField.dart';
import 'package:trivia/widgets/PrimaryButton.dart';
import 'package:trivia/widgets/SecondaryButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Registration extends StatefulWidget {
  static const String routeName = "registration";
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> with ValidationMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();
  final TextEditingController birthDateTextController = TextEditingController();
  bool obscureText = false;
  bool visibility = false;

  String user;
  DateTime _dateTime;
  String _travelDate;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        centerTitle: true,
        title: Text(
          "Registration",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: CustomTextFormField(
                  labelText: "First Name",
                  hintText: null,
                  textEditingController: firstNameTextController,
                  textInputType: TextInputType.name,
                  validate: validateName,
                  iconData: Icons.person,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: CustomTextFormField(
                  labelText: "Last Name",
                  hintText: null,
                  textEditingController: lastNameTextController,
                  textInputType: TextInputType.name,
                  validate: validateName,
                  iconData: Icons.person,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTapCancel: () => selectDate(context),
                child: Container(
                  child: CustomTextFormField(
                    labelText: "Date of Birth",
                    hintText: "mm-dd-yyyy",
                    textEditingController: birthDateTextController,
                    textInputType: TextInputType.datetime,
                    validate: null,
                    iconData: Icons.calendar_today,
                  ),
                ),
              ),
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
                hintText: null,
                textEditingController: passwordTextController,
                obscureText: obscureText,
                onTap: setPasswordVisibility,
                validate: validatePassword,
              ),
              SizedBox(
                height: 20.0,
              ),
              PasswordField(
                labelText: "Confirm Password",
                hintText: null,
                textEditingController: confirmPasswordTextController,
                obscureText: obscureText,
                onTap: setPasswordVisibility,
                validate: validatePassword,
              ),
              Visibility(
                  visible: visibility,
                  child: Center(
                      child: Text(
                    "Passwords do not match",
                    style: TextStyle(fontSize: 10.0, color: Colors.red),
                  ))),
              SizedBox(
                height: 20.0,
              ),
              PrimaryButton(
                  text: "Register",
                  iconData: Icons.app_registration,
                  onPress: register),
              SizedBox(
                height: 20.0,
              ),
              SecondaryButton(
                  text: "Already have an account? Login!",
                  onPress: () {
                    navigateToLogin(context);
                  })
            ]),
          ),
        ),
      ),
    ));
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void register() {
    if (formKey.currentState.validate()) {
      if (validateSamePassword(
          passwordTextController.text, confirmPasswordTextController.text)) {
        Navigator.pushNamed(context, Dashboard.routeName);
        visibility = false;
      } else {
        print("yes?");
        setState(() {
          visibility = true;
        });
      }
    } else {
      print("Invalid input");
      if (validateSamePassword(
          passwordTextController.text, confirmPasswordTextController.text)) {
        print("1?");
        setState(() {
          visibility = false;
        });
      } else {
        print("2?");
        setState(() {
          visibility = true;
        });
      }
    }
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, Login.routeName);
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "Birthdate",
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
        _travelDate = DateFormat('MM-dd-yyyy').format(_dateTime);
        birthDateTextController.text = _travelDate;
      });
    }
  }
}
