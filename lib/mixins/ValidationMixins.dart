class ValidationMixin{

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
  
  String validateAddress(String value){
    if(value.length >= 10){
      return null;
    }
    return "Address is too short.";
  }
  
}