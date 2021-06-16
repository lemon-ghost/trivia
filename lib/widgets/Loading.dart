import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(251, 232, 166, 1),
      child: Center(
        child: SpinKitRing(size: 50, color: Color.fromRGBO(48, 60, 108, 1)),
      ),
    );
  }
}