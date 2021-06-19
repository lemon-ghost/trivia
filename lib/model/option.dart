import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Option {
  final String letter;
  final String option;
  final bool isCorrect;
  final int order;

  const Option({
    @required this.letter,
    @required this.option,
    @required this.isCorrect,
    @required this.order,
  });
}