import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../../widget/custom_functions.dart';
import '../../login/view/login_screen.dart';

class ResetPasswordController extends GetxController {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isVisibleNewPassword = false;
  bool isVisibleConfirmPassword = false;

  resetPassword({String? stToken}) async {
    Map<String, dynamic> data = {
      ApiConstant.newPassword: newPasswordController.text,
      ApiConstant.confirmPassword: confirmPasswordController.text,
      ApiConstant.isForget: '1',
    };

    showLoader();
    var response = await ApiCall.postApiCall(
      endPoint: Apis.changePassword,
      params: data,
      isLoader: true,
      isFormData: true,
      showSuccess: true,
      token: stToken,
      isHeader: true
    );
    if (response != null) {
      if (response[ApiConstant.statuscode] == 200) {
        Get.to(() => const LoginScreen());
      }
    }
  }
}
