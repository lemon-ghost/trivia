import 'package:trivia/pages/Login.dart';
import 'package:trivia/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Dashboard",
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50.0),
              Text("Hey, this is the dashboard"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                child: PrimaryButton(
                    text: "Log out", iconData: Icons.logout, onPress: logout),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() {
    Navigator.pushNamed(context, Login.routeName);
  }
}
