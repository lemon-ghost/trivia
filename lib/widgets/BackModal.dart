  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia/utils/Constants.dart';

  class BackModal extends StatelessWidget {
    final String title;
    final String description;

    BackModal({
      @required this.title,
      @required this.description
    });
  
    @override
    Widget build(BuildContext context) {
      return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 16,
      child: Container(
        height: MediaQuery.of(context).size.height / 3.0,
        width: 360.0,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
              Container(
                  child: Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Constants.scaffdarker),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Constants.primaryDarker),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Constants.scaffoldBackgroundColor),
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    },
                    child: Text(
                      "Yes",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Constants.primaryColor),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Constants.darkprimary),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Constants.darkprimary),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  }