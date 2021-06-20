import 'package:flutter/material.dart';
import 'package:trivia/model/option.dart';
import 'package:trivia/model/question.dart';
import 'package:trivia/utils/util.dart';

class OptionsDisplay extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsDisplay({ 
    Key key,
    @required this.question,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
        children: Utils.heightBetween(
          question.options
              .map((option) => buildOption(context, option))
              .toList(),
          height: 8,
        ),
    );
  }

   Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);

    return GestureDetector(
      onTap: () {
        onClickedOption(option);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
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
      return option.isCorrect ? Colors.green : Colors.red;
    }
  }
}