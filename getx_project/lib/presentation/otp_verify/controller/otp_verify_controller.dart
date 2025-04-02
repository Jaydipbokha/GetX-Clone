
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../../constant/get_storage_constant.dart';
import '../../../widget/custom_functions.dart';
import '../../reset_password/view/reset_password_screen.dart';

class OtpVerifyController extends GetxController {
  final List<String> otp = List.filled(4, '');

  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  otpVerify({String? email}) async {
    Map<String, dynamic> data = {
      ApiConstant.email: email,
      ApiConstant.oneTimePassword: otp.join(),
    };

    showLoader();
    var response = await ApiCall.postApiCall(
      endPoint: Apis.verifyOtp,
      params: data,
      isLoader: true,
      isFormData: true,
      showSuccess: true,
      isHeader: false,
    );
    if (response != null) {
      if (response[ApiConstant.statuscode] == 200) {
        Get.to(
          () => ResetPasswordScreen(
            stBearerToken: response[GetStorageConstant.token],
          ),
        )!.then((value){
          otp.clear();
        });
      }
    }
  }
}
