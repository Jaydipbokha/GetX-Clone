import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utiles/assets.dart';
import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/text_widget.dart';
import '../controller/otp_verify_controller.dart';

class OtpVerifyScreen extends StatefulWidget {
  String? email;

  OtpVerifyScreen({this.email, super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
   OtpVerifyController controller = Get.put(OtpVerifyController());


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
                child: Image.asset(AppAssets.verifyOtp),
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
                        AppStrings.otpVerify,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        '${AppStrings.otpVerifyHintText}${widget.email}',
                        fontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 50,
                            child: TextFormField(
                              focusNode: controller.focusNodes[index],
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                controller.otp[index] = value;
                                if (value.isNotEmpty && index < 3) {
                                  FocusScope.of(context).requestFocus(
                                      controller.focusNodes[index + 1]);
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).requestFocus(
                                      controller.focusNodes[index - 1]);
                                }
                              },
                              decoration: const InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        stTitle: AppStrings.stContinue,
                        stBackColor: AppColors.blackColor,
                        stTitleColor: AppColors.whiteColor,
                        stFunction: () {
                          if (controller.otp.contains('')) {
                            Get.snackbar(
                              "Error",
                              "Please enter all OTP digits",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            controller
                                .otpVerify(email: widget.email); // Call API if all fields are filled
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
