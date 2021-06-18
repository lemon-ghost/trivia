import 'dart:math';

class DummyData {

  Map defaultUser(){
    Map user = {
    "email": "lukevs@gmail.com",
    "password": "miri<3pin@a",
    "fname": "Luke",
    "lname": "Villabado",
    "pic": "assets/images/012-eagle.png",
    "dob": "11-11-2001",
    "scores":{
      "General Knowledge": 130,
      "Music": 180,
      "Film": 235,
      "Video Games": 140,
      "History": 95,
      "Science & Nature": 115,
      "Mythology": 195,
      "Animals": 165
      }
    };

    return user;
  }


  List getScores(Map user, String cat) {
    List toReturn = [];

    toReturn.add({
      "pic": "assets/images/050-fox.png",
      "name": "Player One",
      "score": 250,
    });
    
    toReturn.add({
      "pic": "assets/images/012-eagle.png",
      "name": "Player Two",
      "score": 200,
    });
    
    toReturn.add({
      "pic": "assets/images/avatar1.png",
      "name": "Player Three",
      "score": 150,
    });
    
    toReturn.add({
      "pic": "assets/images/avatar2.png",
      "name": "Player Four",
      "score": 100,
    });
    
    toReturn.add({
      "pic": "assets/images/avatar2.png",
      "name": "Player Four",
      "score": 50,
    });
    
    toReturn.add({
      "pic": user["pic"],
      "name": user["fname"]+ " " + user["lname"],
      "score": user["scores"][cat],
    });

    return toReturn;
  }

}