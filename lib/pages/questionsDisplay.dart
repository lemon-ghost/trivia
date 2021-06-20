import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia/model/option.dart';
import 'package:trivia/model/question.dart';
import 'package:trivia/model/questions.dart';
import 'package:trivia/pages/Dashboard.dart';
import 'package:trivia/utils/Constants.dart';
import 'package:trivia/utils/util.dart';

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
  int correct = 0;

  _QuestionsDisplayState({this.user});
  initState() {
    super.initState();

    question = widget.questions.questionList.first;
    controller = PageController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )                         
                      ),
                      subtitle: Text(
                        "Score: $score",
                        style: TextStyle(
                          fontSize: 16, 
                          color: Colors.white),
                        ),
                      trailing: CircleAvatar(
                        child: Image.asset('assets/images/fox.png'),
                        radius: 35.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
        body: (answered == widget.questions.questionList.length)
        ? buildResult(question: question, user: user)
        : PageView.builder(
        controller: controller,
        physics:new NeverScrollableScrollPhysics(),
        itemCount: widget.questions.questionList.length,
        itemBuilder: (context, index) {
          final Question question = widget.questions.questionList[index];
          curPage = index;
          return buildQuestion(question: question);
        }, 
      ),
    );
  }
  Widget buildResult({@required Question question, @required Map user}){
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 80),
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Constants.scaffdarker,
                      border: Border.all(
                        color: Constants.primaryDarker,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 80),
                        Text(
                          "Your score: " + score.toString(),
                          style: TextStyle(
                            color: Constants.primaryColor, 
                            fontSize: 30, 
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Your best score: " + user['scores'][question.category].toString(),
                          style: TextStyle(
                            color: Constants.primaryDarker,
                            fontSize: 20, 
                          ),
                        ),
                        SizedBox(height: 20),
                        Flexible(
                          child: Text(
                            getComment(question),
                            style: TextStyle(
                              color: Colors.black, 
                              fontSize: 24, 
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 0, 
                    right: 0, 
                    top: -30,
                    child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Constants.scaffdarker,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                        "$correct / " + widget.questions.questionList.length.toString(),
                        style: TextStyle(
                          color: Constants.primaryColor, 
                          fontSize: 25, 
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                      )
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                        Dashboard(
                          user: user,
                          fromProf: false,
                        )
                      ));
              },
              child: Text("Home"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(90, 35),
              ),
            ),
          ],
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
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal:8),
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
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      if(curPage < widget.questions.questionList.length-1) {
                        moveQuestion(index: ++curPage, jump: true);
                      }
                    },
                    child: Text("Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
          Text(
            question.question,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
              (err && !question.isLocked)? Text("Please choose an option.") : Text(""),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if(answered == widget.questions.questionList.length-1) answered++;       
                    if(curPage < widget.questions.questionList.length-1 && question.isLocked) {
                      if(question.selectedOption.isCorrect) {
                        correct++;
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
                      answered++;
                      moveQuestion(index: ++curPage, jump: true);
                     
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
                    print(answered);
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
          border: Border.all(color: Constants.primaryDarker),
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
      return Colors.grey.shade200;
    } else {
      if(question.isLocked) {
        return option.isCorrect? Colors.green : Colors.red;
      }
      return Colors.grey.shade500;
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

  String getComment(Question question) {
    String comment;
    double percent = correct/widget.questions.questionList.length;
    
    if(percent == 1) {
      comment = "Congratulations you got a perfect score!";
    } else if(percent < 1 && percent >= 0.8) {
      comment = "Wow you did great!";
    } else if(percent < 0.8 && percent >= 0.6) {
      comment = "You did well!";
    } else if(percent < 0.6 && percent >= 0.4) {
      comment = "You can do better!";
    } else {
      comment = "You need more practice!";
    }

    if(score > user['scores'][question.category]) {
      comment = "Congratulations you set a new high score!";
    }

    if(score > user['scores'][question.category]) {
      user['scores'][question.category] = score;
    }

    return comment;
  }
}