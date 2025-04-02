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
import '../../forgot_password/view/forgot_password_screen.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColor.withOpacity(0.9),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(AppAssets.loginItem),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomText(
                            AppStrings.logIn,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          AppStrings.welcomeBackToRestaurantPos,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextFiled(
                          controller: controller.userNameController,
                          stTitle: AppStrings.userName,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Test',
                          validator: (val) {
                            return AppValidators.emptyValidation(
                                val, AppStrings.userName);
                          },
                        ),
                        GetBuilder<LoginController>(
                            id: "visibility",
                            builder: (context) {
                              return CustomTextFiled(
                                controller: controller.passwordController,
                                stTitle: AppStrings.password,
                                keyboardType: TextInputType.text,
                                hintText: '*********',
                                isObSecure: !controller.isVisible,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.isVisible =
                                        !controller.isVisible;
                                    controller.update(['visibility']);
                                  },
                                  child: (controller.isVisible)
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: GetBuilder<LoginController>(
                                id : 'isRememberMe',
                                builder: (controller) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10, top: 3),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                          width: 10,
                                          child: Checkbox(
                                            value: controller.isRemembered,
                                            fillColor: WidgetStateProperty.all(AppColors.themeColor),
                                            onChanged: (value) => controller.toggleRememberMe(),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        CustomText(
                                          AppStrings.rememberMe,
                                          fontSize: 14,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(ForgotPasswordScreen());
                                  },
                                  child: CustomText(
                                    AppStrings.forgotPassword,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          stTitle: AppStrings.logIn,
                          stBackColor: AppColors.blackColor,
                          stTitleColor: AppColors.whiteColor,
                          stFunction: () {
                            if (formKey.currentState!.validate()) {
                              hideKeyboard(context);
                              controller.login();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
