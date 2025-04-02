import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../api/apis.dart';
import '../../../constant/get_storage_constant.dart';
import '../../../main.dart';
import '../../login/view/login_screen.dart';
import '../../profile/model/user_profile_response_model.dart';
import '../model/table_response_model.dart';

class TableController extends GetxController {

  bool isLoading = true;

  List<Datum> tableData = [];

  UserProfileModel? userProfileData;

  getTableData() async {
    // showLoader();
    var response =
    await ApiCall.getApiCall(endPoint: Apis.tableList, isLoader: true );
    if (response != null) {
      TableModel data = TableModel.fromJson(response);
      tableData = data.data;
      isLoading = false;
      update(['isLoading']);
      getUserProfile();
    }else{
      isLoading = false;
      update(['isLoading']);
    }
  }

  getUserProfile() async {
    // showLoader();
    var response =
    await ApiCall.getApiCall(endPoint: Apis.profile, isLoader: false );
    if (response != null) {
      userProfileData = UserProfileModel.fromJson(response);
    }else{

    }
  }

  logoutUser() async {
    // showLoader();
    var response =
    await ApiCall.getApiCall(endPoint: Apis.logout, isLoader: false );
    if (response != null) {
      localData.erase();
      Get.to(() => const LoginScreen());
    }else{

    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getTableData();
    });
  }

}