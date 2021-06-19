import 'package:flutter/material.dart';
import 'package:trivia/model/option.dart';
import 'package:html_unescape/html_unescape.dart';
import "dart:math";

class Question {
  final String question;
  final List<Option> options;
  final String category;
  final String type;
  final String difficulty;
  bool isLocked;
  Option selectedOption;

  Question({
    @required this.question,
    @required this.options,
    @required this.category,
    @required this.type,
    @required this.difficulty,
    this.isLocked = false,
    this.selectedOption,
  }); 

  factory Question.fromJson(Map<String, dynamic> json) {
    var temp;
    var unescape = HtmlUnescape();
    var letters = ['A', 'B', 'C', 'D'];
    List<Option> optionsList = [];

    temp = getRandomElement(letters);
    var let = (json['type'] == 'boolean')? 'A' : temp;
    var convertedOption = unescape.convert(json['correct_answer']);
    optionsList.add(Option(
      order: setOrder(let),
      letter: let,
      option: convertedOption,
      isCorrect: true,
    ));
    letters.remove(temp);

    while(letters.length > 0) {
      temp = (letters.length == 1)? 0 : getRandomIndex(letters);
      let = (json['type'] == 'boolean')? 'B' : letters[temp];
      var opt = (json['type'] == 'boolean')? json['incorrect_answers'][0] : json['incorrect_answers'][temp];
      convertedOption = unescape.convert(opt);
      optionsList.add(Option(
        order: setOrder(let),
        letter: let,
        option: convertedOption,
        isCorrect: false,
      ));
      letters.remove(letters[temp]);
      json['incorrect_answers'].remove(opt);
      if(json['type'] == 'boolean'){break;}
    }

    optionsList.sort((a, b) => a.order.compareTo(b.order));
    var convertedQuestion = unescape.convert(json['question']);

    return Question(
      question: convertedQuestion,
      options: optionsList,
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
    );
  } 
}

T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
}

int getRandomIndex<T>(List<T> list) {
  final random = new Random();
  return random.nextInt(list.length);
}

int setOrder(String letter) {
  var order;

  switch(letter) {
    case 'A':
      order = 1;
      break;
    case 'B':
      order = 2;
      break;
    case 'C':
      order = 3;
      break;
    case 'D':
      order = 4;
      break;
    default:
      break;
  }

  return order;
}