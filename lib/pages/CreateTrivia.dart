import 'package:flutter/material.dart';
import 'package:trivia/model/option.dart';
import 'package:trivia/pages/questionsDisplay.dart';
import 'package:trivia/utils/Constants.dart';
import 'package:trivia/services/apicall.dart';
import 'package:trivia/model/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia/widgets/BackModal.dart';
import 'package:trivia/widgets/Loading.dart';

class CreateTrivia extends StatefulWidget {
  final Map user;
  CreateTrivia({this.user});

  @override
  _CreateTriviaState createState() => _CreateTriviaState(user: this.user);
}

class _CreateTriviaState extends State<CreateTrivia> {
  Map user={}; 
  Questions questions;
  
  _CreateTriviaState({this.user});
  @override

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String url = "";
  String category;
  double amount = 0, type = 0, difficulty = 0;
  bool err = false;
  String errMsg = "";
  bool loading = false;
  bool clicked = false;

  List amountList = [
    "10",
    "25",
    "50"
  ];

  List typeList = [
    "Any",
    "Multiple Choice",
    "True / False"    
  ];

  List difficultyList = [
    "Any",
    "Easy",
    "Medium",
    "Hard",
  ];

  List categoryList = [
    "Gen Knowledge", 
    "Music", 
    "Film", 
    "Video Games", 
    "History",
    "Nature",
    "Mythology",
    "Animals"
    ];

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) {
              return BackModal(title: "Discard Changes?",description: "Changes you have made may not be saved. Do you still want to continue?");;
            });
      },
      child: Scaffold(
        backgroundColor: Constants.scaffoldBackgroundColor,
        appBar: AppBar(
          leading: null,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Create!",
            style: GoogleFonts.poppins(
               fontWeight: FontWeight.w500,
            )
          ),
        ),
        body: (loading && clicked)
        ? Loading()
        :SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create"
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 75,
                      child: Form(
                        key: _formKey,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            hintText: "Category: ",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(
                                  105, 108, 121, 0.7),
                            ),
                            focusedBorder:
                                OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants
                                    .primaryColor,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder:
                                OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants
                                    .primaryColor,
                                width: 1,
                              ),
                            ),
                            enabledBorder:
                                OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants
                                    .accentDarker,
                                width: 1,
                              ),
                            ),
                            errorBorder:
                                OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                          ),
                          icon:
                              Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          value: category,
                          onChanged: (newValue) {
                            setState(() {
                              category = newValue;
                            });
                          },
                          validator: (value) =>
                              value == null
                                  ? 'Required'
                                  : null,
                          items: categoryList
                              .map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  Text("Amount"),
                  Slider(
                    min: 0,  
                    max: 2, 
                    value: amount,
                    onChanged: (newAmount){
                      setState(() => amount = newAmount);
                    },
                    divisions: 2,
                    label: amountList.elementAt(amount.toInt()),
                  ),

                  SizedBox(height: 20),
                  Text("Type"),
                  Slider(
                    min: 0,  
                    max: 2, 
                    value: type,
                    onChanged: (newType){
                      setState(() => type = newType);
                    },
                    divisions: 2,
                    label: typeList.elementAt(type.toInt()),
                  ),

                  SizedBox(height: 20),
                  Text("Difficulty"),
                  Slider(
                    min: 0,  
                    max: 3, 
                    value: difficulty,
                    onChanged: (newDifficulty){
                      setState(() => difficulty = newDifficulty);
                    },
                    divisions: 3,
                    label: difficultyList.elementAt(difficulty.toInt()),
                  ),

                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: (){
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      var amtTemp = "amount="+amountList.elementAt(amount.toInt());
                      var typeTemp = "";
                      var diffTemp = (difficulty == 0)? "" : "&difficulty=" +  difficultyList.elementAt(difficulty.toInt()).toLowerCase();
                      var categoryTemp = "&category=";

                      switch(type.toInt().toString()) {
                        case "0":
                          typeTemp = "";
                          break;
                        case "1":
                          typeTemp = "&type=multiple";
                          break;
                        case "2":
                          typeTemp = "&type=boolean";
                          break;
                        default:
                          break;
                      }
                      switch(category) {
                        case "Gen Knowledge":
                          categoryTemp = categoryTemp + "9";
                          break;                      
                        case "Music":
                          categoryTemp = categoryTemp + "12";
                          break;
                        case "Film":
                          categoryTemp = categoryTemp + "11";
                          break;
                        case "Video Games":
                          categoryTemp = categoryTemp + "15";
                          break;                      
                        case "History":
                          categoryTemp = categoryTemp + "23";
                          break;                      
                        case "Nature":
                          categoryTemp = categoryTemp + "17";
                          break;                      
                        case "Mythology":
                          categoryTemp = categoryTemp + "20";
                          break;
                        case "Animals":
                          categoryTemp = categoryTemp + "27";
                          break;                      
                        default:
                          break;
                      }
                      
                      url = "https://opentdb.com/api.php?"+amtTemp+categoryTemp+diffTemp+typeTemp;
                      print(url);

                      setState((){
                        loading = true;
                        clicked = true;
                      });
                      

                      getQuestions(url).then((Questions result) {
                        print(result.questionList.length);
                        setState(() {
                          questions = result;
                          loading = false;
                        });
                        if(result.responseCode == 1) {
                          err = true;
                          errMsg = "There is not enough questions. Please change the parameters.";
                          return;
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                          QuestionsDisplay(
                            user: user,
                            questions: questions, 
                          )
                        ));
                      });    
                    },
                    child: Text("Create Trivia!"),
                  ),
                  (err)
                    ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          errMsg,
                          style: TextStyle(
                            color: Constants.fail,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                    : Text("")
                ],
              ),
            ),
          ),
        )
      ),
    );
  } 
}