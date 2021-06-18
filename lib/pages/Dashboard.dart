import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:trivia/pages/Home.dart';
import 'package:trivia/pages/Login.dart';
import 'package:trivia/pages/Profile.dart';
import 'package:trivia/pages/Scoreboard.dart';
import 'package:trivia/utils/Constants.dart';
//import 'package:trivia/widgets/BottomBar.dart';
import 'package:trivia/widgets/Loading.dart';
import 'package:trivia/widgets/PrimaryButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

enum _SelectedTab { home, scoreboard, profile }

class Dashboard extends StatefulWidget {
  static const String routeName = "dashboard";
  Map user={};

  Dashboard({this.user});
  @override
  _DashboardState createState() => _DashboardState(user: this.user);
}

class _DashboardState extends State<Dashboard> {
  Map user={};
  var _selectedTab = _SelectedTab.home;

  _DashboardState({this.user});
  @override
  Widget build(BuildContext context) {
    return user.isEmpty ? Loading() : _build(context);
  }
  
  Widget _build(BuildContext context) {
    print(user);
    return Scaffold(
      //backgroundColor: Constants.primaryColor,
      //key: _scaffoldkey,
      appBar: _selectedTab == _SelectedTab.profile ? null : AppBar(
        leading: null,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Trivia!",
          style: GoogleFonts.poppins(
             fontWeight: FontWeight.w500,
          )
        )
      ),
      bottomNavigationBar: bottomBar(context),
      body: getTab()
    );
  }

   Widget getTab() {

    if (_selectedTab == _SelectedTab.scoreboard) {
      return Scoreboard(user: this.user);
    }

    if (_selectedTab == _SelectedTab.profile) {
      return Profile();
    }

    if (_selectedTab == _SelectedTab.home) return Home();
  }

  Widget bottomBar(BuildContext context) {
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border(
          top: BorderSide(color: Colors.white70),
        )),
        child: SalomonBottomBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: _selectedTab == _SelectedTab.home
                  ? Icon(Icons.home)
                  : Icon(Icons.home_outlined),
              title: Text("Home"),
              selectedColor: Constants.primaryDarker,
            ),

            /// Scoreboard
            SalomonBottomBarItem(
              icon: _selectedTab == _SelectedTab.scoreboard
                  ? Icon(Icons.assignment)
                  : Icon(Icons.assignment_outlined),
              title: Text("Scoreboard"),
              selectedColor: Constants.primaryDarker,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: _selectedTab == _SelectedTab.profile
                  ? Icon(Icons.person_rounded)
                  : Icon(Icons.person_outline_rounded),
              title: Text("Profile"),
              selectedColor: Constants.primaryDarker,
            ),

          ],
        ),
      ),
    );
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  void logout() {
    Navigator.pushNamed(context, Login.routeName);
  }
}
