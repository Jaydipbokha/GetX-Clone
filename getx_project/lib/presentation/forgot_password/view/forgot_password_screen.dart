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
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.all(50.0),
                child: Image.asset(AppAssets.forgotPassword),
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomText(
                          AppStrings.forgotPassword,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          textAlign: TextAlign.center,
                        ),
                        CustomText(
                          AppStrings.smallHintsForForgotPassword,
                          fontSize: 18,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFiled(
                          controller: controller.emailNumberController,
                          stTitle: AppStrings.userName,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Test',
                          validator: (val) {
                            return AppValidators.emptyValidation(
                                val, AppStrings.userName);
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          stTitle: 'Send',
                          stBackColor: AppColors.blackColor,
                          stTitleColor: AppColors.whiteColor,
                          stFunction: (){
                            if (formKey.currentState!.validate()) {
                              hideKeyboard(context);
                              controller.setOtp();
                            }
                          },
                        )
                      ],
                    ),
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
