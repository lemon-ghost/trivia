import 'package:flutter/material.dart';
import 'package:trivia/utils/Constants.dart';
import 'package:trivia/utils/DummyData.dart';
import 'package:trivia/widgets/ScorerRow.dart';
import 'dart:math';

class Scoreboard extends StatefulWidget {
  Map user;
  @override
  Scoreboard({this.user});
  _ScoreboardState createState() => _ScoreboardState(user: this.user);
}

class _ScoreboardState extends State<Scoreboard> with DummyData {
  String category;
  List temp;
  Map user;

  _ScoreboardState({this.user});

  @override
  initState() {
    super.initState();
    if(category!=null){ getZaScores();}
  }

  getZaScores() {
    List ex = getScores(user, category);
    ex.sort((a, b) => b["score"].compareTo(a["score"]));
    setState(() {
      this.temp = ex;
      print(temp);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.scaffoldBackgroundColor,
        body: SafeArea(
            child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Text("Scoreboard",
                        style: TextStyle(
                            color: Constants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0)),
                    SizedBox(height: 40.0),
                    Container(
                        child: new DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          fillColor: Constants.scaffoldBackgroundColor,
                          prefixIcon: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Icon(Icons.category),
                          ),
                          labelText: "Category",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)))),
                      items: <String>[
                        'General Knowledge',
                        'Music',
                        'Film',
                        'Video Games',
                        'History',
                        'Science & Nature',
                        'Mythology',
                        'Animals'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      value: category,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (balue) {
                        setState(() {
                          category = balue;
                          print("current category: $category");
                          getZaScores();
                        });
                      },
                    )),
                    SizedBox(height: 10.0),
                    header(),
                    SizedBox(height: 10.0),
                    (category == null)
                        ? notChosenCat()
                        : Container(
                            padding: EdgeInsets.only(top: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1,
                                )),
                            height: MediaQuery.of(context).size.height * 0.47,
                            child: ListView.builder(
                                itemCount: temp.length,
                                itemBuilder: (context, int index) {
                                  return ScorerRow(
                                      rank: index + 1,
                                      path: temp[index]["pic"],
                                      name: temp[index]["name"],
                                      score: temp[index]["score"]);
                                }),
                          )
                  ],
                ))));
  }

  Widget notChosenCat() {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.black45,
            width: 1,
          )),
      height: MediaQuery.of(context).size.height * 0.47,
      child: Center(
        child: Text("Pick a Category and see your place on the Scoreboard!",
            textAlign: TextAlign.center,
          )
        ),
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
                child: Text("Rank"),
              ),
              SizedBox(width: 20.0),
              //person
              Container(child: Text("Player Name"))
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
}
