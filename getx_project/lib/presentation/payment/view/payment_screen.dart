import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_functions.dart';
import '../../../widget/custom_textfiled.dart';
import '../../../widget/snack_bar.dart';
import '../../../widget/text_widget.dart';
import '../../order/model/all_ordered_item_response_model.dart';
import '../controller/payment_controller.dart';

class PaymentScreen extends StatefulWidget {
  final OrderSummary? stOrderSummary;
  num? tableId;
  num? orderId;
   PaymentScreen({super.key,  this.stOrderSummary, this.tableId, this.orderId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentController paymentController;


  @override
  void initState() {
    super.initState();
    double netAmount = 0.0;
    if (widget.stOrderSummary?.netAmount != null) {
      netAmount = double.tryParse(widget.stOrderSummary!.netAmount.toString()) ?? 0.0;
    }
    paymentController = Get.put(PaymentController(netAmount, widget.tableId,widget.orderId));
    paymentController.selectPaymentItem(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: AppStrings.payment,
        isBack: true,
        centerTile: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 8),
          child: Stack(
            children: [
              ListView(
                children: [
                  CustomText(
                    AppStrings.quickCash,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: GetBuilder<PaymentController>(
                      id: 'stQuickCash',
                      builder: (context) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: paymentController.quickCase.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                paymentController.selectItem(index);
                                // Temporarily change background color
                                paymentController.tempHighlightIndex = index;
                                paymentController.update(['stQuickCash']);

                                Future.delayed(const Duration(milliseconds: 200), () {
                                  paymentController.tempHighlightIndex = -1;
                                  paymentController.update(['stQuickCash']);
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: paymentController.tempHighlightIndex == index
                                      ? Colors.grey.withOpacity(0.7) // Temporary highlight color
                                      : paymentController.selectedQuickCaseIndex == index
                                      ? AppColors.blackColor.withOpacity(0.5) // Selected color
                                      : AppColors.themeColor.withOpacity(0.1),
                                  // color: AppColors.themeColor.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  border: Border.all(
                                      width: 1, color: AppColors.hintTextColor),
                                ),
                                child: Center(
                                  child: CustomText(
                                    paymentController.quickCase[index],
                                    fontSize: 14,
                                    color: paymentController.selectedQuickCaseIndex == index
                                        ? AppColors.whiteColor :   AppColors.blackColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    AppStrings.paymentType,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: GetBuilder<PaymentController>(
                      id : 'stPaymentType',
                      builder: (context) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: paymentController.paymentType.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                paymentController.selectPaymentItem(index);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: paymentController.selectedPaymentTypeIndex == index
                                        ?  AppColors.blackColor.withOpacity(0.5) // Selected color
                                        : AppColors.themeColor.withOpacity(0.1),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                    border: Border.all(
                                        width: 1, color: AppColors.hintTextColor)),
                                child: Center(
                                  child: CustomText(
                                    paymentController.paymentType[index]['name'],
                                    fontSize: 14,
                                    color: paymentController.selectedPaymentTypeIndex == index
                                        ? AppColors.whiteColor :   AppColors.blackColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFiled(
                          stTitle: AppStrings.customerName,
                          hintText: AppStrings.customerName,
                          controller: paymentController.customerNameController,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextFiled(
                          stTitle: AppStrings.mobileNo,
                          hintText: AppStrings.mobileNo,
                          keyboardType: TextInputType.number,
                          controller: paymentController.mobileNoController,
                        ),
                      ),
                    ],
                  ),
                  GetBuilder<PaymentController>(
                    id: 'stPaymentType',
                    builder: (controller) {
                      return Row(
                        children: [
                          paymentController.selectedPaymentTypeIndex == 1 ? Expanded(
                            child: CustomTextFiled(
                              stTitle: AppStrings.bankAmount,
                              hintText: AppStrings.bankAmount,
                              controller: paymentController.bankAmountController,
                              keyboardType: TextInputType.number,
                            ),
                          ) :
                          Expanded(
                            child: CustomTextFiled(
                              stTitle: AppStrings.cashAmount,
                              hintText: AppStrings.cashAmount,
                              controller: paymentController.cashAmountController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          paymentController.selectedPaymentTypeIndex == 2 ?   const SizedBox(
                            width: 10,
                          ):  SizedBox(),
                          paymentController.selectedPaymentTypeIndex == 2 ?   Expanded(
                            child: CustomTextFiled(
                              stTitle: AppStrings.bankAmount,
                              hintText: AppStrings.bankAmount,
                              controller: paymentController.bankAmountController,
                              keyboardType: TextInputType.number,
                            ),
                          ): SizedBox(child: Text(''),)
                        ],
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomTextFiled(
                      stTitle: AppStrings.Notes,
                      hintText: AppStrings.Notes,
                      controller: paymentController.notesController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border:
                          Border.all(width: 1.5, color: AppColors.themeColor),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: bottomCommonRow(AppStrings.totalItems, '-'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child: Divider(
                            height: 1,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: bottomCommonRow(
                            AppStrings.Total,
                            '₹ ${widget.stOrderSummary!.subTotal ?? '-'}',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                          ),
                          child: bottomCommonRow(
                              AppStrings.discountWithSign, '₹ ${widget.stOrderSummary!.discountAmount ?? '-'}',
                              stFontWeight: FontWeight.w500,
                              stTextColor: AppColors.blackColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: bottomCommonRow(
                            AppStrings.gst,
                            '₹ ${widget.stOrderSummary!.totalTaxRate ?? '-'}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child: Divider(
                            height: 1,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: bottomCommonRow(
                            AppStrings.roundUP,
                            '₹ ${widget.stOrderSummary!.roundUp ?? '-'}',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,),
                          child: bottomCommonRow(
                            AppStrings.totalPayable,
                            ' ₹ ${widget.stOrderSummary!.netAmount ?? '-'}',
                            stFontWeight: FontWeight.w500,
                            stTextColor: AppColors.blackColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: GetBuilder<PaymentController>(
                            id: 'stTotalPaying',
                            builder: (controller) {
                              return bottomCommonRow(
                                AppStrings.totalPaying,
                                '₹ ${controller.totalPaying.toStringAsFixed(2)}',
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child: Divider(
                            height: 1,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          child: GetBuilder<PaymentController>(
                            id: 'stTotalPaying',
                            builder: (controller) {
                              double balance = (controller.totalPaying > controller.netAmount)
                                  ? 0.0
                                  : controller.netAmount - controller.totalPaying;
                              return bottomCommonRow(
                                AppStrings.balance,
                                ' ₹ ${balance.toStringAsFixed(2)}',
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(color: AppColors.themeColor),
                          child: GetBuilder<PaymentController>(
                            id: 'stTotalPaying',
                            builder: (controller) {
                              return bottomCommonRow(
                                AppStrings.changeReturn,
                                '₹ ${controller.changeReturn.toStringAsFixed(2)}',
                                stFontWeight: FontWeight.w500,
                                stTextColor: AppColors.blackColor,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        stTitle: AppStrings.save,
                        stBackColor: AppColors.blackColor,
                        stTitleColor: AppColors.whiteColor,
                        stFunction: (){
                          if (paymentController.customerNameController.text.isEmpty) {
                            showSnakBar(1, msg: 'Please Enter Customer Name');
                          } else if (paymentController.mobileNoController.text.isEmpty) {
                            showSnakBar(1, msg: 'Please Enter Mobile No');
                          }else if (paymentController.mobileNoController.text.length != 10) {
                            showSnakBar(1, msg: 'Please Enter Valid Mobile No');
                          }else {
                            hideKeyboard(context);
                            paymentController.getPrintBill(
                                widget.stOrderSummary!);
                          }
                        },
                      ),
                    ),
                   /* Expanded(
                      child: CustomButton(
                        stTitle: AppStrings.savePrint,
                        stBackColor: AppColors.blackColor,
                        stTitleColor: AppColors.whiteColor,
                      ),
                    ),*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomCommonRow(String stTitle, String stValue,
      {FontWeight? stFontWeight = FontWeight.normal, Color? stTextColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          stTitle,
          fontSize: 16,
          fontWeight: stFontWeight ?? null,
          color: stTextColor ?? AppColors.blackColor,
        ),
        CustomText(
          stValue,
          fontSize: 16,
          fontWeight: stFontWeight ?? null,
          color: stTextColor ?? AppColors.blackColor,
        ),
      ],
    );
  }
}
