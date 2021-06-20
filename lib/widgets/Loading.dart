import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trivia/utils/Constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.scaffdarker,
      child: Center(
        child: SpinKitRing(size: 50, color: Constants.primaryColor),
      ),
    );
  }
}