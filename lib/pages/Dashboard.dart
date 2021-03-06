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
  bool fromProf=false;

  Dashboard({this.user,this.fromProf});
  @override
  _DashboardState createState() => _DashboardState(user: this.user,fromProf: this.fromProf);
}

class _DashboardState extends State<Dashboard> {
  bool fromProf;
  Map user={};
  var _selectedTab;

  _DashboardState({this.user,this.fromProf});

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      setTab();
    }

  setTab(){
    setState(() {
      _selectedTab =(fromProf)?_SelectedTab.profile:_SelectedTab.home;
    });
  }
  
  Widget build(BuildContext context) {
    return user.isEmpty ? Loading() : _build(context);
  }
  
  Widget _build(BuildContext context) {
    print(user);
    return Scaffold(
      //backgroundColor: Constants.primaryColor,
      //key: _scaffoldkey,
      appBar: AppBar(
        leading: null,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Trivia!",
          style: GoogleFonts.poppins(
             fontWeight: FontWeight.w500,
          )
        ),
        bottom: _selectedTab == _SelectedTab.home? PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            color: Constants.scaffdarker,
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Hello",
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.black54),
                  ),
                Text(
                  user['fname'] + " " + user['lname'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Constants.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ) : PreferredSize(preferredSize: Size.fromHeight(0), child: Container()),
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
      return Profile(user: this.user);
    }

    if (_selectedTab == _SelectedTab.home) return Home(user: this.user);
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
