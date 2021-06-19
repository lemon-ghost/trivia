import 'dart:convert';
import 'package:trivia/model/question.dart';

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));

class Questions {
    Questions({
        this.responseCode,
        this.questionList,
    });

    int responseCode;
    List<Question> questionList;

    factory Questions.fromJson(Map<String, dynamic> json) {
      return Questions(
        responseCode: json["response_code"],
        questionList: List<Question>.from(json["results"].map((x) => Question.fromJson(x))),
      );
    } 
}
