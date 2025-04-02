import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../../widget/custom_functions.dart';
import '../../otp_verify/view/otp_verify_screen.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailNumberController = TextEditingController();

  setOtp() async {
    Map<String, dynamic> data = {
      ApiConstant.email: emailNumberController.text,
    };

    showLoader();
    var response = await ApiCall.postApiCall(
      endPoint: Apis.sendOtp,
      params: data,
      isLoader: true,
      isFormData: true,
      showSuccess: true,
      isHeader: false,
    );
    if (response != null) {
      if (response[ApiConstant.statuscode] == 200) {
        Get.to(
          () => OtpVerifyScreen(
            email: emailNumberController.text,
          ),
        )?.then((value){
          emailNumberController.text = '';
        });
      }
    }
  }
}
