import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/get_storage_constant.dart';
import '../../../main.dart';
import '../../table/view/table_screen.dart';
import '../model/login_response_model.dart';
import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../../widget/custom_functions.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;
  bool isRemembered = false;

  LoginResponseModel? loginResponse;

  void toggleRememberMe() {
    isRemembered = !isRemembered;
    update(['isRememberMe']);
  }

  login() async {
    Map<String, dynamic> data = {
      ApiConstant.loginType: "password",
      ApiConstant.password: passwordController.text,
      ApiConstant.email: userNameController.text,
    };
    showLoader();
    var response = await ApiCall.postApiCall(
        endPoint: Apis.login,
        params: data,
        isLoader: true,
        isFormData: true,
        showSuccess: true,
        isHeader: false);
    if (response != null) {
      loginResponse = LoginResponseModel.fromJson(response);
      localData.write(GetStorageConstant.token, loginResponse!.token);
      if (isRemembered) {
        rememberMeData.write('rememberMe', true);
        rememberMeData.write('username', userNameController.text);
        rememberMeData.write('password', passwordController.text);
      }else{
       rememberMeData.remove('rememberMe');
       rememberMeData.remove('username');
       rememberMeData.remove('password');
      }
      Get.offAll(() => const TableScreen());
    }
  }

  @override
  void onInit() {
    super.onInit();
    isRemembered = rememberMeData.read('rememberMe') ?? false;
    if (isRemembered) {
      userNameController.text = rememberMeData.read('username') ?? '';
      passwordController.text = rememberMeData.read('password') ?? '';
    }
    update(['isRememberMe']);
  }
}
