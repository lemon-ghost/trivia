import 'package:flutter/material.dart';

class PredefinedTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final bool obscureText;
  final TextInputType textInputType;
  final Function validate;

  PredefinedTextFormField(
    {
      @required this.labelText,
      @required this.hintText,
      @required this.textEditingController,
      @required this.obscureText,
      @required this.textInputType,
      @required this.validate
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          
        ),
        validator: validate,
      )
    );
  }
}