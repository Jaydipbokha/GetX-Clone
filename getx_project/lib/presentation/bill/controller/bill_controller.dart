
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../model/bill_preview_response_model.dart';

class BillController extends GetxController {

  num? stOrderId;

  BillController({this.stOrderId});

  BillPreviewModel? stBillPreviewModel;
  bool isLoading = true;

  getPrintBill() async {

    Map<String, dynamic> data = {
      ApiConstant.orderId: stOrderId,
    };
    var response = await ApiCall.postApiCall(
        endPoint: Apis.orderItemPreview,
        params: data,
        isLoader: false,
        isFormData: false,
        isHeader: true);
    if (response != null) {
      stBillPreviewModel = BillPreviewModel.fromJson(response);
      isLoading = false;
      update(['stBillItem','isLoading']);
    } else {
      isLoading = false;
      update(['stBillItem','isLoading']);
      return;
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPrintBill();
    });

    super.onInit();
  }
}