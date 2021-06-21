import 'package:flutter/material.dart';
import 'package:trivia/pages/Dashboard.dart';
import 'package:trivia/utils/Constants.dart';
import 'package:trivia/utils/DummyData.dart';
import 'package:trivia/widgets/PrimaryButton.dart';
import 'package:trivia/mixins/ValidationMixins.dart';
import 'Login.dart';

class Profile extends StatefulWidget {
  Map user;
  static const String routeName = "profile";

  @override
  Profile({this.user});
  _ProfileState createState() => _ProfileState(user: this.user);
}

class _ProfileState extends State<Profile> with DummyData, ValidationMixin{
  Map user;
  final TextEditingController fnameController = new TextEditingController();
  final TextEditingController lnameController = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _ProfileState({this.user});

  @override
  void initState() {
    super.initState();
    //user = defaultUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBackgroundColor,
      body:ListView(
        children: <Widget> [
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *.90),
                    child: GestureDetector(
                        onTap:(){
                          settings(user);
                        },
                        child: Icon(Icons.settings,
                          color: Constants.primaryColor, 
                        ),
                      ),
                  ),
                  SizedBox(height: 10.0),
                  CircleAvatar(
                    backgroundImage: AssetImage(user["pic"]),
                    radius: 60.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    user["fname"]+" "+user["lname"],
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0)
                  ),
                  SizedBox(height: 30.0),
                  Text("Your Top Results:"),
                  SizedBox(height: 20.0),
                  header(),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.black45,
                          width: 1,
                        )),
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView(
                      children: [
                        results(Icons.book,"General Knowledge", user["scores"]["General Knowledge"]),
                        results(Icons.music_note,"Music", user["scores"]["Music"]),
                        results(Icons.camera_alt,"Film", user["scores"]["Film"]),
                        results(Icons.games,"Video Games", user["scores"]["Video Games"]),
                        results(Icons.flag,"History", user["scores"]["History"]),
                        results(Icons.terrain,"Science & Nature", user["scores"]["Science & Nature"]),
                        results(Icons.wb_sunny,"Mythology", user["scores"]["Mythology"]),
                        results(Icons.pets,"Animals", user["scores"]["Animals"]),
                      ],
                    ),
                  ),
                  //SizedBox(height: 20.0),
                ],
              ) 
            )
          )
        ]
      )
    );
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.black45,
            width: 1,
          )),
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //number rank
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.0),
              Container(
                child: Text("Category"),
              ),
            ],
          ),

          //score
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text("Score"),
          ),
        ],
      ),
    );
  }

  Widget results(icon, name, score){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Constants.scaffdarker,
      ),
      height: 40.0,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //number rank
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //person
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(icon, color: Constants.primaryColor,),
                    SizedBox(width: 15),
                    Text(name)
                  ],
                ),
              ),
            ],
          ),

          //score
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 5.0),
            child: Text(score.toString()),
          ),
        ],
      ),
    );
  }

  void settings(Map user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .80,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Settings",
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Constants.primaryColor,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fnameController,
                        validator: validateName2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          hintText: user["fname"],
                          labelText: "Edit First Name",
                          labelStyle: TextStyle(
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: lnameController,
                        validator: validateName2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          hintText: user["lname"],
                          labelText: "Edit Last Name",
                          labelStyle: TextStyle(
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      PrimaryButton(text: "Edit Profile", iconData: Icons.edit, onPress: edit),
                      SizedBox(height: 20),
                      PrimaryButton(text: "Logout", iconData: Icons.logout, onPress: logout),
                    ],
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void logout() {
    Navigator.pushNamed(context, Login.routeName);
  }

  void edit() {
    if(this.fnameController.text.isEmpty && this.lnameController.text.isNotEmpty){
      if(formKey.currentState.validate()){
        setState(() {
          user["lname"] = lnameController.text;
          lnameController.clear();
        });
      }
    } else if (this.lnameController.text.isEmpty && this.fnameController.text.isNotEmpty){
      if(formKey.currentState.validate()){
        setState(() {
          user["fname"] = fnameController.text;   
          fnameController.clear();  
        });
      }
    } else if (this.lnameController.text.isEmpty && this.fnameController.text.isEmpty){
    } else {
      if(formKey.currentState.validate()){
        setState(() {
          user["fname"] = fnameController.text;   
          user["lname"] = lnameController.text;  
          fnameController.clear();
          lnameController.clear();     
        });
      }
    }
    
    if(formKey.currentState.validate()){
      print("user after prof edit: $user");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard(user: this.user,fromProf: true)), (route) => false);
      //Navigator.pop(context);
    } else {
      print("Invalid Inputs");
    }
    
  }

}