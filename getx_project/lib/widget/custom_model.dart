import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utiles/color.dart';
import '../utiles/string.dart';
import 'custom_button.dart';
import 'text_widget.dart';

class CustomModel extends StatelessWidget {
  final String title;
  final String description;
  final String? buttonOneName;
  final String? buttonTwoName;
  final Widget? body;
  final Function? okFun;

  const CustomModel(
      {super.key,
      required this.title,
      this.buttonOneName,
      this.buttonTwoName,
      required this.description,
      this.body, this.okFun});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title,
            ),
            description != '' ? const SizedBox(height: 10) : SizedBox(),
            description != ''
                ? Text(description, style: const TextStyle(fontSize: 16))
                : SizedBox(),
            if (body != null) ...[
              const SizedBox(height: 10),
              body!,
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    stTitle: buttonOneName ?? AppStrings.cancel,
                    stBackColor: AppColors.whiteColor,
                    stFunction: () {
                      Get.back();
                    },
                    stTitleColor: AppColors.blackColor,
                    stBorderColor: AppColors.blackColor,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    stTitle: buttonTwoName ?? AppStrings.submit,
                    stBackColor: AppColors.blackColor,
                    stFunction: () {
                      if(okFun != null){
                        Get.back();
                        okFun!.call();
                      }else {
                        Get.back();
                      }
                    },
                    stTitleColor: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
