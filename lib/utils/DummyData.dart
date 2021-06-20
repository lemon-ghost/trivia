import 'dart:math';

class DummyData {

  Map defaultUser(){
    Map user = {
    "email": "lukevs@gmail.com",
    "password": "P@ssw0rd",
    "fname": "Luke",
    "lname": "Villabado",
    "pic": "assets/images/031-meerkat.png",
    "dob": "11-11-2001",
    "scores":{
      "General Knowledge": 1,
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
      "pic": "assets/images/005-parrot.png",
      "name": "Player Three",
      "score": 150,
    });
    
    toReturn.add({
      "pic": "assets/images/013-crocodile.png",
      "name": "Player Four",
      "score": 100,
    });
    
    toReturn.add({
      "pic": "assets/images/032-snake.png",
      "name": "Player Five",
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
