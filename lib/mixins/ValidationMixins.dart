import 'package:trivia/utils/DummyData.dart';

class ValidationMixin{
  DummyData temp;

  String validateEmail(String value){
    if(value.contains("@")){
      return null;
    }
    return "Incorrect email format.";
  }
  
  String validatePassword(String value){
    if(value.length >= 8){
      return null;
    }
    return "Password is too short.";
  }

  bool validateSamePassword(String orig, String conf){
    if(orig == conf){
      return true;
    }
    return false;
  }
  
  String validateName(String value){
    if(value.length <= 3){
      return "Name is too short.";
    }else if(value.length >= 10){
      return "Name is too long.";
    }
    return null;
  }

  String validateName2(String value){
    if(value.isNotEmpty && value.length <= 3){
      return "Name is too short.";
    }else if(value.isNotEmpty && value.length >= 10){
      return "Name is too long.";
    }
    return null;
  }

//dummy data
  String validateUser(Map value){
    Map user = temp.defaultUser();

    if(value["email"]==user["email"]){

      if(value["password"]==user["password"]){

        return null;
      }

      return "Incorrect Password";
    }

    return "Email not found";

  }
  
}