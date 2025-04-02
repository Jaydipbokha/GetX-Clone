

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utiles/color.dart';

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}


hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

showLoader()  {
  Get.dialog(Dialog(
    backgroundColor: AppColors.transparentColor,
    elevation: 0,
    child: Container(
      height: 50,
      child: Center(
        child: CircularProgressIndicator(color: AppColors.themeColor),
      ),
    ),
  ));
}


hideLoader() {
  Get.back();
}
