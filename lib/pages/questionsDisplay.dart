import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia/model/option.dart';
import 'package:trivia/model/question.dart';
import 'package:trivia/model/questions.dart';
import 'package:trivia/utils/Constants.dart';
import 'package:trivia/utils/util.dart';
import 'package:trivia/widgets/BackModal.dart';

class QuestionsDisplay extends StatefulWidget {
  final Questions questions;
  final Map user;

  const QuestionsDisplay({ 
    Key key,
    @required this.user,
    @required this.questions,
  }) : super(key: key);

  @override
  _QuestionsDisplayState createState() => _QuestionsDisplayState(user: this.user);
}

class _QuestionsDisplayState extends State<QuestionsDisplay> {
  Map user = {};
  PageController controller;
  Question question;
  int curPage = 0;
  int answered = 0;
  Option selectedOption;
  Question currentQuestion;
  var optionColor;
  bool err = false;
  int score = 0;

  _QuestionsDisplayState({this.user});
  initState() {
    super.initState();

    question = widget.questions.questionList.first;
    controller = PageController();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) {
              return BackModal(title: "Exit Quiz?",description: "Your progress will not be saved. Are you sure?");
            });
      }, child: Scaffold(
          backgroundColor: Constants.scaffoldBackgroundColor,
          appBar: AppBar(
          leading: null,
          elevation: 0,
          centerTitle: true,
          title: Text(
              "Answer!",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              )
            ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListTile(
                        title: Text(
                          user['fname'] + " " + user['lname'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )                         
                        ),
                        subtitle: Text(
                          "Score: $score",
                          style: TextStyle(
                            fontSize: 15, 
                            color: Colors.white),
                          ),
                        trailing: CircleAvatar(
                          child: Image.asset(user["pic"]),
                          radius: 25.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
          body: PageView.builder(
          controller: controller,
          physics:new NeverScrollableScrollPhysics(),
          itemCount: widget.questions.questionList.length,
          itemBuilder: (context, index) {
            final Question question = widget.questions.questionList[index];
            curPage = index;
            return buildQuestion(question: question);
          }, 
        ),
      ),
    );
  }

  Widget buildQuestion({
    @required Question question}) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal:8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if(curPage > 0) {
                        moveQuestion(index: --curPage, jump: true);
                      }
                    },
                    child: Text("Previous",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    )
                  ),
                  Text(curPage.toString()),
                  GestureDetector(
                    onTap: () {
                      if(curPage < widget.questions.questionList.length-1) {
                        moveQuestion(index: ++curPage, jump: true);
                      }
                    },
                    child: Text("Next",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            question.question,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 8),
          Text(
            "Choose your answer from the given",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
          ),
          SizedBox(height: 32),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
                children: Utils.heightBetween(
                  question.options
                    .map((option) => buildOption(context, option))
                    .toList(),
                  height: 8,
                ),
            )
            
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (err)? Text("Please choose an option.") : Text(""),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {             
                    if(curPage < widget.questions.questionList.length-1 && question.isLocked) {
                      if(question.selectedOption.isCorrect) {
                        switch (question.difficulty) {
                          case "easy":
                            score+=1;
                            break;
                          case "medium":
                            score+=3;
                            break;
                          case "hard":
                            score+=5;
                            break;
                          default:
                            break;
                        }
                      }
                      moveQuestion(index: ++curPage, jump: true);
                      answered++;
                      print(answered);
                      print(widget.questions.questionList.length);
                    }

                    setState(() {
                      optionColor = (selectedOption != null && selectedOption.isCorrect) ? Colors.green : Colors.red;
                    });
                    
                    if(selectedOption != null && selectedOption == question.selectedOption) {
                      question.isLocked = true;
                      err = false;
                      
                    } else {
                      err = true;
                      
                    }
                  },
                  child: (answered == widget.questions.questionList.length-1)
                    ? Text("Finish")
                    : (question.isLocked)
                        ? Text("Next") 
                        : Text("Submit")
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget buildOption(BuildContext context, Option option) {
    optionColor = getColorForOption(option, question);

    return GestureDetector(
      onTap: () {
        selectOption(option);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: optionColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            buildOptionChoice(option),
          ],
        ),
      ),
    );
  }

  Widget buildOptionChoice(Option option) => Container(
      height: 50,
      child: Row(children: [
        Text(
          option.letter,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(width: 12),
        Flexible(
            child: Text(
            option.option,
            style: TextStyle(fontSize: 20),
          ),
        )
      ]),
    );

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (!isSelected) {
      return Constants.accentColor;
    } else {
      if(question.isLocked) {
        return option.isCorrect? Constants.pass : Constants.fail;
      }
      return Constants.scaffdarker;
    }
  }

  void selectOption(Option option) {
    if (question.isLocked) {
      return;
    } else {
      setState(() {
        question.selectedOption = option;
        selectedOption = option;
        currentQuestion = question;
      });
    }
  }

  void nextQuestion({int index}) {
    if(index+1 == widget.questions.questionList.length) return;
    final nextPage = controller.page + 1;
    controller.jumpToPage(nextPage.toInt());
  }

  void moveQuestion({int index, bool jump = false}) {
    final nextPage = controller.page + 1;
    final indexPage = index ?? nextPage.toInt();

    setState(() {
      question = widget.questions.questionList[indexPage];
    });

    if(jump) {
      controller.jumpToPage(indexPage);
    }
  }
}