import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../../widget/custom_functions.dart';
import '../model/kot_preview_response_model.dart';

class KotController extends GetxController {

  num? stOrderId;
  num? stTableId;

  bool isLoading = true;

  KotController({this.stOrderId, this.stTableId});

  final List<dynamic> kotItem = [
    {"name": "Samosa", "Quantity": '1'},
    {"name": "Gulab Jambu", "Quantity": '10'},
    {"name": "Basundi", "Quantity": '5'},
    {"name": "Laddu","Quantity": '9'},
    {"name": "Pizza","Quantity": '2'},
    {"name": "Ice Cream","Quantity": '50'},
    {"name": "Samosa", "Quantity": '1'},
    {"name": "Gulab Jambu", "Quantity": '10'},
    {"name": "Basundi", "Quantity": '5'},
    {"name": "Laddu","Quantity": '9'},
    {"name": "Pizza","Quantity": '2'},
    {"name": "Ice Cream","Quantity": '50'},
  ];

  KotPreviewModel? stKotPreviewModel;

  getKotItem() async {
    Map<String, dynamic> data = {
      ApiConstant.orderId: stOrderId,
    };


    var response = await ApiCall.postApiCall(
        endPoint: Apis.kotItemPreview,
        params: data,
        isLoader: false,
        isFormData: false,
        isHeader: true);
    if (response != null) {
      stKotPreviewModel = KotPreviewModel.fromJson(response);
      isLoading = false;
      update(['stKotItem','isLoading']);
    } else {
      update(['stKotItem','isLoading']);
      return;
    }
  }

  createKot() async {
    Map<String, dynamic> data = {
      ApiConstant.tableId: stTableId,
      ApiConstant.orderId: stOrderId,
    };

    showLoader();
    var response = await ApiCall.postApiCall(
        endPoint: Apis.createKot,
        params: data,
        isLoader: true,
        isFormData: false,
        isHeader: true);
    if (response != null) {
      Get.back();
      update(['stKotItem','isLoading']);
    } else {
      Get.back();
      update(['stKotItem','isLoading']);
      return;
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
       getKotItem();
    });
    super.onInit();
  }

}