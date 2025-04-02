


import '../widget/custom_functions.dart';
import 'string.dart';

class AppValidators {

  static final AppValidators _instance = AppValidators._internal();

  factory AppValidators (){
    return _instance;
  }

  AppValidators._internal();

  static String? emptyValidation(String? val, String message) {
    if (val == null || val.isEmpty) {
      String formattedMessage = capitalizeFirstLetter(message);

      return "$formattedMessage ${AppStrings.isRequired}*";
    } else {
      return null;
    }
  }

}