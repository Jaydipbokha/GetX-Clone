import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../../widget/custom_model.dart';
import '../../bill/model/bill_preview_response_model.dart';
import '../model/report_detail_response_model.dart';
import '../view/report_detail_screen.dart';

class ReportDetailController extends GetxController {
  String? stType;

  ReportDetailController({this.stType});

  var salesData = <SalesData>[];
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  BillPreviewModel? stBillPreviewModel;

  bool isLoading = false;
  bool isLoadingViewBill = true;
  bool isNoDataFound = false;

  GetReportModel? reportModel;

  getReportData() async {
    isLoading = true;
    update(['stOrderData']);
    Map<String, dynamic> data = {
      ApiConstant.type: stType,
      ApiConstant.fromDate: fromDateController.text,
      ApiConstant.toDate: toDateController.text,
    };

    var response = await ApiCall.postApiCall(
        endPoint: Apis.reportData,
        params: data,
        isLoader: false,
        isFormData: false,
        isHeader: true);
    if (response != null) {
      reportModel = GetReportModel.fromJson(response);

      // Ensure `data` is not null before mapping
      var parsedData = reportModel?.data?.data ?? [];


      List<SalesData> updatedSalesData = parsedData.map((item) {
        return SalesData(
          "#${item.id ?? 'N/A'}", // Handle null ID
          item.saledate?.toString() ?? 'N/A', // Handle null sale date
          "#${item.id ?? 'N/A'}", // Handle null ID
          item.cashAmount?.toDouble() ?? 0.0, // Use ?. to avoid null check error
          item.onlineAmount?.toDouble() ?? 0.0, // Provide default value
          double.tryParse(item.netamount?.toString() ?? "0.0") ?? 0.0, // Handle null safely
        );
      }).toList();

      salesData.assignAll(updatedSalesData);
      isNoDataFound = salesData.isEmpty; // Check if data is empty

      isLoading = false;
      update(['stOrderData']);

    }else{
      isLoading = false;
      isNoDataFound = true;
      update(['stOrderData']);
    }

/*    if (response != null) {
      try {
        reportModel = GetReportModel.fromJson(response);
        isLoading = false;
      } catch (e) {
        print("JSON Parsing Error: $e"); // Debugging
        isLoading = false;
        isNoDataFound = true;
        update(['stOrderData']);
        return;
      }
      isLoading = false;
      var parsedData = reportModel?.data?.data ?? [];
      print("Parsed Data: $parsedData"); // Debugging
    }*/
  }

  getViewBill({String? stOrderId}) async {

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
      isLoadingViewBill = false;
      update(['isLoadingOrderData', 'stBillItem']);
    } else {
      isLoadingViewBill = false;
      update(['isLoadingOrderData', 'stBillItem']);
      return;
    }
  }



  void showDynamicDialog(
      BuildContext context, String title, String description, Widget stBody, String? buttonOneName, String? buttonTwoName, Function stFun ) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomModel(
          title: title,
          description: description,
          body: stBody,
          buttonOneName: buttonOneName,
          buttonTwoName: buttonTwoName,
          okFun: stFun,
        );
      },
    );
  }

}

class SalesData {
  final String saleID;
  final String saleDate;
  final String invoiceNumber;
  final double cashAmount;
  final double onlineAmount;
  final double netAmount;

  SalesData(this.saleID, this.saleDate, this.invoiceNumber, this.cashAmount,
      this.onlineAmount, this.netAmount);
}