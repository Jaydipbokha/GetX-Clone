import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utiles/assets.dart';
import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../utiles/validators.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_functions.dart';
import '../../../widget/custom_textfiled.dart';
import '../../../widget/text_widget.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  String? stBearerToken;
   ResetPasswordScreen({this.stBearerToken, super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColor.withOpacity(0.9),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(AppAssets.resetPassword),
              ),
            ),
          ),
          // Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 35, left: 10, right: 10, bottom: 35),
                  child: Column(
                    children: [
                      CustomText(
                        AppStrings.restPassword,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5,),
                      CustomText(
                        AppStrings.restPasswordHitText,
                        fontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      GetBuilder<ResetPasswordController>(
                          id: "newPasswordVisibility",
                          builder: (context) {
                            return CustomTextFiled(
                              controller: controller.newPasswordController,
                              stTitle: AppStrings.newPassword,
                              keyboardType: TextInputType.text,
                              hintText: '*********',
                              isObSecure: !controller.isVisibleNewPassword,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.isVisibleNewPassword =
                                  !controller.isVisibleNewPassword;
                                  controller.update(['newPasswordVisibility']);
                                },
                                child: (controller.isVisibleNewPassword)
                                    ? const SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: Icon(
                                      Icons.visibility_outlined,
                                      size: 18,
                                    ),
                                  ),
                                )
                                    : const SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: Icon(
                                      Icons.visibility_off,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (val) {
                                return AppValidators.emptyValidation(
                                    val, AppStrings.password);
                              },
                            );
                          }),

                      GetBuilder<ResetPasswordController>(
                          id: "confirmPasswordVisibility",
                          builder: (context) {
                            return CustomTextFiled(
                              controller: controller.confirmPasswordController,
                              stTitle: AppStrings.confirmPassword,
                              keyboardType: TextInputType.text,
                              hintText: '*********',
                              isObSecure: !controller.isVisibleConfirmPassword,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.isVisibleConfirmPassword =
                                  !controller.isVisibleConfirmPassword;
                                  controller.update(['confirmPasswordVisibility']);
                                },
                                child: (controller.isVisibleConfirmPassword)
                                    ? const SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: Icon(
                                      Icons.visibility_outlined,
                                      size: 18,
                                    ),
                                  ),
                                )
                                    : const SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: Icon(
                                      Icons.visibility_off,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (val) {
                                return AppValidators.emptyValidation(
                                    val, AppStrings.password);
                              },
                            );
                          }),

                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        stTitle: AppStrings.restPassword,
                        stBackColor: AppColors.blackColor,
                        stTitleColor: AppColors.whiteColor,
                        stFunction: (){
                          if(controller.newPasswordController.text == controller.confirmPasswordController.text)
                          {
                            hideKeyboard(context);
                            controller.resetPassword();
                          }else{
                            Get.snackbar(
                              "Error",
                              AppStrings.passwordDoseNotMatch,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
