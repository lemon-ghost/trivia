import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:trivia/model/questions.dart';

Future<Questions> getQuestions(String url) async{
  final response = await http.get(Uri.parse(url));
  return questionsFromJson(response.body);
}