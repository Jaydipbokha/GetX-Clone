import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/text_widget.dart';
import '../controller/bill_controller.dart';
import '../model/bill_preview_response_model.dart';

class BillScreen extends StatefulWidget {
  num? stOrderId;
  BillScreen({super.key, this.stOrderId});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {

 late BillController controller;

  @override
  void initState() {
    controller = Get.put(BillController(stOrderId: widget.stOrderId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: AppStrings.billPreview,
        centerTile: true,
        isBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: GetBuilder<BillController>(
          id: 'isLoading',
          builder: (controller) {
            if(controller.isLoading){
              return Center(child: CircularProgressIndicator(color: AppColors.themeColor,),);
            }
            if(controller.stBillPreviewModel?.data == null){
              return Center(child: CustomText(
                'No Item Added In Order',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Customer Detail
                customerDetail(),
                const SizedBox(
                  height: 10,
                ),

                /// Order Detail
                stBillInfoRow(AppStrings.billOrderNo, '${controller.stBillPreviewModel?.data!.orderNo ?? '-'}'),
                stBillInfoRow(AppStrings.billDate, '${controller.stBillPreviewModel?.data!.date ?? '-'}'),
                stBillInfoRow(AppStrings.billName, '${controller.stBillPreviewModel?.data!.customerName ?? '-'}'),
                stBillInfoRow(AppStrings.billMobile, '${controller.stBillPreviewModel?.data!.mobile ?? '-'}'),

                const SizedBox(
                  height: 10,
                ),

                /// BillTableHeader
                stBillTableHeader(),

                Flexible(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.hintTextColor.withOpacity(0.2),
                          offset: const Offset(4, 0),
                          blurRadius: 7,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: GetBuilder<BillController>(
                      id: 'stBillItem',
                      builder: (controller) {
                        if (controller.stBillPreviewModel?.data == null) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final scrollController = ScrollController(); // Explicit ScrollController

                        return Scrollbar(
                          controller: scrollController, // Assign the controller here
                          thumbVisibility: true,
                          thickness: 5,
                          radius: const Radius.circular(5),
                          child: ListView.builder(
                            controller: scrollController, // Use the same controller
                            itemCount: controller.stBillPreviewModel!.data!.items.length,
                            itemBuilder: (context, index) {
                              var data = controller.stBillPreviewModel!.data!.items[index];
                              return stOrderItemView(data);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),


                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  decoration: BoxDecoration(
                      color: AppColors.themeColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Expanded(
                        child: GetBuilder<BillController>(
                          id: 'stBillItem',
                          builder: (context) {
                            return Column(
                              children: [
                                stRowBillFooter(AppStrings.SubTotal, '₹' +'${controller.stBillPreviewModel?.data!.subtotal ?? ''}'),
                                stRowBillFooter(AppStrings.CGST, '₹' +'${controller.stBillPreviewModel?.data!.cgst ?? ''}'),
                                stRowBillFooter(AppStrings.SGST,'₹' +'${controller.stBillPreviewModel?.data!.sgst ?? ''}'),
                                stRowBillFooter(AppStrings.Discount, '₹' +'${controller.stBillPreviewModel?.data!.discount ?? ''}'),
                                stRowBillFooter(
                                  AppStrings.RoundUp,
                                  '₹' +'${controller.stBillPreviewModel?.data!.round ?? ''}',
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      AppStrings.Total,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    CustomText(
                                      '₹' +'${controller.stBillPreviewModel?.data!.total ?? ''}',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Center(
                  child: CustomText(
                    AppStrings.ThankYouForVisiting,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Center(
                  child: CustomText(
                      controller.stBillPreviewModel?.data!.fullDate ?? ''
                  ),
                ),

               /* CustomButton(
                  stTitle: AppStrings.PrintBill,
                  stBackColor: AppColors.blackColor,
                  stTitleColor: AppColors.whiteColor,
                )*/
              ],
            );
          }
        ),
      ),
    );
  }

  ///Customer Detail
  Widget customerDetail() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            'Axone Infotech,',
            fontSize: 15,
          ),
          CustomText(
            'Near, Gajera school,',
            fontSize: 15,
          ),
          CustomText(
            'Katargam, Surat, Gujarat 395005',
            fontSize: 15,
          ),
          CustomText(
            'GST : 24AXNFM7624F1ZC',
            fontSize: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              'Table: ${controller.stBillPreviewModel?.data!.tablename ?? ''}',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Order Detail
  Widget stBillInfoRow(String stTitle, String stValue) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomText(
            stTitle,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          flex: 7,
          child: CustomText(
            stValue,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  /// Bill Table Header
  Widget stBillTableHeader() {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 15),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          topLeft: Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              AppStrings.Item,
              color: AppColors.whiteColor,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  AppStrings.Qty,
                  color: AppColors.whiteColor,
                ),
                CustomText(
                  AppStrings.Amount,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Bill Item View
  Widget stOrderItemView(Item data) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 7, left: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.name ?? '',
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.quantity.toString() ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                   '₹ '+ data.amount.toString(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Bill Footer Row
  Widget stRowBillFooter(String stTitle, String stValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          stTitle,
          // AppStrings.SubTotal,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        CustomText(
          // '227.00',
          stValue,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ],
    );
  }
}
