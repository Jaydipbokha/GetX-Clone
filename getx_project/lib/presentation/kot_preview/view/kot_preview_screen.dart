import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/text_widget.dart';
import '../controller/kot_controller.dart';
import '../model/kot_preview_response_model.dart';

class KotPreviewScreen extends StatefulWidget {
  num? stOrderId;
  num? stTableId;
  KotPreviewScreen({super.key, this.stOrderId, this.stTableId});

  @override
  State<KotPreviewScreen> createState() => _KotPreviewScreenState();
}

class _KotPreviewScreenState extends State<KotPreviewScreen> {
  late KotController controller;

  @override
  void initState() {
    controller = Get.put(KotController(stOrderId: widget.stOrderId, stTableId: widget.stTableId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:  CustomAppBar(
        isBack: true,
        title: AppStrings.kotPreview,
        centerTile: true,
      ),
      body: GetBuilder<KotController>(
        id : 'isLoading',
        builder: (loadingController) {
          if(controller.isLoading){
            return Center(child: CircularProgressIndicator(color: AppColors.themeColor,),);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<KotController>(
                    id: 'stKotItem',
                  builder: (context) {
                    return Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        'Table: ${controller.stKotPreviewModel?.data!.tablename ?? ''}',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                ),

                const SizedBox(
                  height: 10,
                ),

                /// Order Detail Informations
                GetBuilder<KotController>(
                  id: 'stKotItem',
                  builder: (context) {
                    return orderDetail();
                  }
                ),

                kotHeaderView(),

                Flexible(
                  flex: 9,
                  child: GetBuilder<KotController>(
                      id: 'stKotItem',
                    builder: (controller) {

                      if (controller.stKotPreviewModel?.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final scrollController = ScrollController();
                      return Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        thickness: 5,
                        radius: const Radius.circular(5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.hintTextColor.withOpacity(0.3),
                                  offset: const Offset(4, 6),
                                  blurRadius: 7,
                                  spreadRadius: 3)
                            ],
                          ),
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: controller.stKotPreviewModel!.data!.items.length,
                            itemBuilder: (context, index) {
                              var data = controller.stKotPreviewModel!.data!.items[index];
                              return orderItem(data: data);
                            },
                          ),
                        ),
                      );
                    }
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                /// Kot Bottom View
                GetBuilder<KotController>(
                    id: 'stKotItem',
                  builder: (context) {
                    return Center(child: CustomText('Order BY :- ${controller.stKotPreviewModel?.data!.entryBy ?? '-'}'));
                  }
                ),
                GetBuilder<KotController>(
                    id: 'stKotItem',
                  builder: (context) {
                    return Center(child: CustomText(controller.stKotPreviewModel?.data!.fullDate ?? '-'));
                  }
                ),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 50,
                  child: CustomButton(
                    stFunction: (){
                      controller.createKot();
                    },
                    stTitle: AppStrings.save,
                    stBackColor: AppColors.blackColor,
                    stTitleColor: AppColors.whiteColor,
                  ),
                )

              ],
            ),
               );
        }
      ),
    );
  }

  /// Order Detail Informations
  Widget orderDetail() {
    return Column(
      children: [
        stKOTPreviewInfoRow(AppStrings.billOrderNo, '${controller.stKotPreviewModel?.data!.orderNo ?? ''}'),
        stKOTPreviewInfoRow(AppStrings.date, '${controller.stKotPreviewModel?.data!.date ?? ''}'),
        stKOTPreviewInfoRow(AppStrings.billName,'${controller.stKotPreviewModel?.data!.customerName ?? ''}'),
      ],
    );
  }

  /// KOT Preview
  Widget stKOTPreviewInfoRow(String stTitle, String stValue) {
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

  /// Kot Order Item View
  Widget orderItem({Item? data}) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      margin: EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            data?.name ?? '',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomText(data!.quantity.toString() ?? ''),
          ),
        ],
      ),
    );
  }

  /// Kot Header View
  Widget kotHeaderView(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            AppStrings.Item,
            color: AppColors.whiteColor,
          ),
          CustomText(
            AppStrings.Qty,
            color: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}
