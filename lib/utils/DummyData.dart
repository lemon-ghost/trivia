import 'dart:math';

class DummyData {
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
      "pic": user["pic"],
      "name": user["fname"]+ " " + user["lname"],
      "score": user["scores"][cat],
    });

    return toReturn;
  }

}
