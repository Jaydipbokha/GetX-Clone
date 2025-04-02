import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utiles/color.dart';

void showSnakBar(int error, {String? msg}) {
  Get.snackbar(
    colorText: AppColors.whiteColor,
    duration: Duration(seconds: 2),
    error == 0 ? 'Success' : "Alert !",
    msg!,
    icon: error == 0
        ?  Icon(Icons.done_sharp, color: AppColors.whiteColor)
        :  Icon(Icons.error_outline, color: AppColors.whiteColor),
    snackPosition: SnackPosition.TOP,
    backgroundColor: error == 0 ? AppColors.greenColor : AppColors.redColor,
  );
}