import 'package:flutter/material.dart';
import 'package:trivia/utils/Constants.dart';

class ScorerRow extends StatelessWidget {
  final int rank;
  final String path;
  final String name;
  final int score;

  ScorerRow({
    @required this.rank,
    @required this.path,
    @required this.name,
    @required this.score,
  });

  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: 15.0),
              Container(
                child: Text(rank.toString()),
              ),
              SizedBox(width: 20.0),
              //person
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 10.0),
                child: Row(
                  children: [
                    Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.primaryColor,
                            image: DecorationImage(
                              image: AssetImage(path),
                              fit: BoxFit.fill,
                            ))),
                    SizedBox(width: 10.0),
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
}
