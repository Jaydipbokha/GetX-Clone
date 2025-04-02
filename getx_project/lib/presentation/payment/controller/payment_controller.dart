

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../order/model/all_ordered_item_response_model.dart';

class PaymentController extends GetxController {
  int tempHighlightIndex = -1;
  int selectedQuickCaseIndex = -1;
  int selectedPaymentTypeIndex = 0;
  double totalPaying = 0.0; // Stores the total tapped amount
  double netAmount; // Will be assigned dynamically
  double changeReturn = 0.0; // Stores the change return
  String stPaymentType = '';
  num? stTableId;
  num? stOrderId;

  TextEditingController customerNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController cashAmountController = TextEditingController();
  TextEditingController bankAmountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  PaymentController(this.netAmount, this.stTableId, this.stOrderId);

  List<String> quickCase = ['10', '20', '50', '100', '200', '500', '2000'];

  void selectItem(int index) {
    double selectedValue = double.parse(quickCase[index]);

    // Add the selected value to totalPaying
    totalPaying += selectedValue;

    // If totalPaying exceeds netAmount, calculate change return
    if (totalPaying > netAmount) {
      changeReturn = totalPaying - netAmount;
    } else {
      changeReturn = 0.0;
    }

    update(['stQuickCash', 'stTotalPaying']); // Notify UI to refresh
  }

  void selectPaymentItem(int index) {
    selectedPaymentTypeIndex = index;
    stPaymentType = paymentType[index]['value']!;
    update(['stPaymentType']); // Notify UI to refresh
  }

  List<Map<String, String>> paymentType = [
    {'name' : 'Cash', 'value' : 'CASH' },
    {'name' : 'Bank', 'value' : 'BANK' },
    {'name' : 'Case & Bank', 'value' : 'CASHBANK' },
    ];

  getPrintBill(OrderSummary stOrderSummary) async {

    Map<String, dynamic> data = {
      ApiConstant.orderId: stOrderId,
      ApiConstant.tableId : stTableId,
      ApiConstant.paymentType : stPaymentType,
      ApiConstant.customerName : customerNameController.text,
      ApiConstant.mobileNo: mobileNoController.text,
      ApiConstant.cashAmount: cashAmountController.text.isEmpty ? 0 : cashAmountController.text,
      ApiConstant.onlineAmount:bankAmountController.text.isEmpty ? 0 : bankAmountController.text,
      ApiConstant.returnAmount: changeReturn,
      ApiConstant.totalPayable:stOrderSummary.netAmount,
      ApiConstant.discountPer: stOrderSummary.discountPer,
      ApiConstant.discountAmt: stOrderSummary.discountAmount,
    };
    var response = await ApiCall.postApiCall(
        endPoint: Apis.orderPayment,
        params: data,
        isLoader: false,
        isFormData: false,
        isHeader: true);
    if (response != null) {
      Get.back();
    } else {

    }
  }
}