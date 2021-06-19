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
                SizedBox(height: 10),
                Text("Categories"),
                SizedBox(height: 5),
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
}