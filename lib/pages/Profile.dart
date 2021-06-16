import 'package:flutter/material.dart';
import 'package:trivia/utils/Constants.dart';
import 'package:trivia/widgets/PrimaryButton.dart';

import 'Login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBackgroundColor,
      body:Column(
        children: [
          SizedBox(height: 80.0),
          Text("Profile"),
          SizedBox(height: 80.0),
          PrimaryButton(iconData: Icons.logout,text: "Logout",onPress: logout)
        ],
      )
    );
  }

  void logout() {
    Navigator.pushNamed(context, Login.routeName);
  }
}