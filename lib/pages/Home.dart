import 'package:flutter/material.dart';
import 'package:trivia/utils/Constants.dart';
import 'package:trivia/pages/CreateTrivia.dart';

class Home extends StatefulWidget {
  final Map user;

  Home({this.user});
  @override
  _HomeState createState() => _HomeState(user: this.user);
}

class _HomeState extends State<Home> {
  Map user = {};

  _HomeState({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5.0),
                Text("Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25.0
                  )),
                SizedBox(height: 10.0),
                /*
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("1. Gen Knowledge"),
                        Text("2. Music"),
                        Text("3. Film"),
                        Text("4. Video Games"),
                      ],
                    ),
                    SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("5. History"),
                        Text("6. Nature"),
                        Text("7. Mythology"),
                        Text("8. Animals")
                      ],
                    ),
                  ]
                ),
                */
                Container(
                    padding: EdgeInsets.only(top: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.black45,
                          width: 1,
                        )),
                    height: MediaQuery.of(context).size.height * 0.48,
                    child: ListView(
                      children: [
                        results(Icons.book,"General Knowledge"),
                        results(Icons.music_note,"Music"),
                        results(Icons.camera_alt,"Film") ,
                        results(Icons.games,"Video Games"),
                        results(Icons.flag,"History"),
                        results(Icons.terrain,"Science & Nature"),
                        results(Icons.wb_sunny,"Mythology"),
                        results(Icons.pets,"Animals"),
                      ],
                    ),
                  ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    print(user);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CreateTrivia(user: user)));
                  },
                  child: Text("Create trivia!"),
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
  
  Widget results(icon, name){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Constants.scaffdarker,
      ),
      height: 30.0,
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
        ],
      ),
    );
  }
}