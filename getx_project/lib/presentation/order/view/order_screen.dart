import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utiles/color.dart';
import '../../../utiles/string.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_appbar_textfield.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfiled.dart';
import '../../../widget/snack_bar.dart';
import '../../../widget/text_widget.dart';
import '../../bill/view/bill_screen.dart';
import '../../kot_preview/view/kot_preview_screen.dart';
import '../../payment/view/payment_screen.dart';
import '../../table/controller/table_controller.dart';
import '../controller/order_controller.dart';
import '../model/all_item_response_model.dart';
import '../model/all_ordered_item_response_model.dart';

class OrderScreen extends StatefulWidget {
  num? stTableId;
  num? isEmptyValue;

  OrderScreen({this.stTableId, this.isEmptyValue, super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderController controller;
  TableController tableController = Get.put(TableController());

  final ScrollController _scrollController =
      ScrollController(); // ScrollController added

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(OrderController(
        stTableId: widget.stTableId, stIsEmptyId: widget.isEmptyValue));
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose of the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          print('did pop... $didPop');
          if (!didPop) {
            controller.isBackFunCall();
          }

          // bool isValue = controller.checkBackValue();
          // Get.back(result: isValue);
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppBar(
            title: 'T - ${widget.stTableId}',
            /* titleWidget: GetBuilder<OrderController>(
              id: 'orderController',
              builder: (context) {
                return controller.isSearching
                    ? CustomAppbarTextfield(
                        controller: controller.stSearchBar,
                      )
                    : CustomText(
                       'T - ${widget.stTableId}',
                        color: AppColors.blackColor,
                        fontSize: 18,
                      );
              },
            ),*/
            centerTile: true,
            isBack: true,
            function: () {
              log('tapped....');
              controller.isBackFunCall();
            },
            /* isActionWidget: GetBuilder<OrderController>(
              id: 'orderController',
              builder: (controller) {
                return controller.isSearching
                    ? IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () {
                          hideKeyboard(context);
                          controller.isSearching = false;
                          controller.stSearchBar.clear();
                          controller.update(['orderController']);
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.search,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () {
                          controller.isSearching = true;
                          controller.update(['orderController']);
                        },
                      );
              },
            ),*/
            bottomWidget: TabBar(
              controller: controller.tabController,
              indicatorColor: AppColors.blackColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.only(bottom: 1),
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    AppStrings.allItems,
                    color: AppColors.blackColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<OrderController>(
                    id: 'totalQuantity',
                    builder: (context) {
                      return CustomText(
                        "${AppStrings.added} ",
                        color: AppColors.blackColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: AppColors.themeColor.withOpacity(0.09),
            child: GetBuilder<OrderController>(
                id: 'orderSummary',
                builder: (context) {
                  return Column(
                    children: [
                      /// Tab Bar View
                      tabBarView(),

                      /// Bottom Calculators View
                      controller.selectedIndex == 1
                          ? bottomCalulatoinView()
                          : const SizedBox()
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  /// Bottom Calculators View
  Widget bottomCalulatoinView() {
    return Container(
      // Fixed height
      height: 265,
      width: double.infinity,
      // Background color
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
      ),
      padding: const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 5),
      child: GetBuilder<OrderController>(
          id: 'orderSummary',
          builder: (con) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  AppStrings.pricingSummary,
                  fontSize: 15,
                  color: AppColors.blackColor,
                ),
                Divider(
                  color: AppColors.blackColor.withOpacity(0.1), // Line color
                  thickness: 1, // Line thickness
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      AppStrings.Subtotal,
                      fontSize: 15,
                      color: AppColors.blackColor.withOpacity(0.4),
                    ),
                    controller.addedItemData?.orderSummary == null ||
                            controller.addedItemData?.orderSummary?.subTotal ==
                                null ||
                            controller.addedItemData?.orderSummary?.subTotal ==
                                '0.0' ||
                            controller.addedItemData?.orderSummary?.subTotal ==
                                '0.00'
                        ? Text('-')
                        : CustomText(
                            '₹ ${controller.addedItemData?.orderSummary!.subTotal}',
                            fontSize: 15,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      AppStrings.tax,
                      fontSize: 15,
                      color: AppColors.blackColor.withOpacity(0.4),
                    ),
                    CustomText(
                      (controller.addedItemData?.orderSummary == null ||
                              controller.addedItemData?.orderSummary
                                      ?.totalTaxRate ==
                                  null ||
                              controller.addedItemData?.orderSummary
                                      ?.totalTaxRate ==
                                  '0.0' ||
                              controller.addedItemData?.orderSummary
                                      ?.totalTaxRate ==
                                  '0.00')
                          ? '-'
                          : '₹ ${controller.addedItemData?.orderSummary!.totalTaxRate}',
                      fontSize: 15,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.showDynamicDialog(
                          context,
                          AppStrings.setDiscount,
                          "",
                          Column(
                            children: [
                              CustomDropdownField(
                                stTitle: AppStrings.discountType,
                                dropdownItems: const [
                                  "Per%",
                                  "Fixed",
                                ],
                                // List of options
                                selectedValue: controller.selectedOption,
                                // Variable to store selected value
                                onChanged: (newValue) {
                                  setState(() {
                                    controller.selectedOption =
                                        newValue; // Update selected value
                                  });
                                },
                                isRequired: true,
                                // Show asterisk (*) if required
                                validator: (value) => value == null
                                    ? "Please select an option"
                                    : null, // Validation
                              ),
                              CustomTextFiled(
                                stTitle: AppStrings.discount,
                                controller: controller.stDiscount,
                                hintText: AppStrings.discount,
                                isRequired: true,
                                keyboardType: TextInputType.name,
                              )
                            ],
                          ),
                          "Cancel",
                          "Save",
                          () {
                            controller.applyDiscountItem();
                          },
                        );
                      },
                      child: Row(
                        children: [
                          CustomText(
                            AppStrings.discount,
                            fontSize: 15,
                            color: AppColors.blackColor.withOpacity(0.4),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.edit_square,
                            color: AppColors.blackColor.withOpacity(0.4),
                            size: 18,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        controller.addedItemData?.orderSummary != null
                            ? CustomText(
                                (controller.addedItemData?.orderSummary ==
                                            null ||
                                        controller.addedItemData?.orderSummary
                                                ?.discountPer ==
                                            null ||
                                        controller.addedItemData?.orderSummary
                                                ?.discountPer ==
                                            '0.0' ||
                                        controller.addedItemData?.orderSummary
                                                ?.discountPer ==
                                            '0.00')
                                    ? ''
                                    : '₹ ${controller.addedItemData?.orderSummary!.discountPer}'
                                        ' (%) ',
                                fontSize: 15,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              )
                            : CustomText(
                                '',
                                fontSize: 15,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                        CustomText(
                          (controller.addedItemData?.orderSummary == null ||
                                  controller.addedItemData?.orderSummary
                                          ?.discountAmount ==
                                      null ||
                                  controller.addedItemData?.orderSummary
                                          ?.discountAmount ==
                                      '0.0' ||
                                  controller.addedItemData?.orderSummary
                                          ?.discountAmount ==
                                      '0.00')
                              ? '-'
                              : '₹ ${controller.addedItemData?.orderSummary!.discountAmount}',
                          fontSize: 15,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.blackColor.withOpacity(0.1), // Line
                  thickness: 1, // Line thickness
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      AppStrings.Total,
                      fontSize: 18,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      (controller.addedItemData?.orderSummary == null ||
                              controller
                                      .addedItemData?.orderSummary?.netAmount ==
                                  null ||
                              controller
                                      .addedItemData?.orderSummary?.netAmount ==
                                  '0.0' ||
                              controller
                                      .addedItemData?.orderSummary?.netAmount ==
                                  '0.00')
                          ? '-'
                          : '₹ ${controller.addedItemData?.orderSummary!.netAmount}',
                      fontSize: 15,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        stTitle: AppStrings.order,
                        stFunction: () {
                          Get.to(() => BillScreen(
                                stOrderId: controller.items.first.orderId,
                              ));
                        },
                        stBackColor: AppColors.blackColor,
                        stTitleColor: AppColors.whiteColor,
                        stFontWeight: FontWeight.w500,
                        stFontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: CustomButton(
                        stTitle: AppStrings.KOT,
                        stFunction: () {
                          if (controller.orderItem.isEmpty) {
                            showSnakBar(1, msg: 'Please Select Items First!');
                          } else {
                            Get.to(() => KotPreviewScreen(
                                  stOrderId: controller.items.first.orderId,
                                  stTableId: widget.stTableId,
                                ))?.then((value) {
                              controller.getAllAddedItem();
                              for (var data in controller.items) {
                                for (var element in data.items) {
                                  element.itemQty = 0;
                                }
                              }
                              // controller.getAllItem();
                            });
                          }
                        },
                        stBackColor: AppColors.blackColor,
                        stTitleColor: AppColors.whiteColor,
                        stFontWeight: FontWeight.w500,
                        stFontSize: 18,
                      ),
                    ),
                  ],
                ),
                tableController.userProfileData!.data!.user!.type == 2
                    ? const SizedBox(
                        height: 7,
                      )
                    : const SizedBox(),
                tableController.userProfileData!.data!.user!.type == 2
                    ? Expanded(
                        child: CustomButton(
                        stTitle: AppStrings.payment,
                        stFunction: () {
                          if (controller.orderItem.isEmpty && controller.hasKotNoItem.isEmpty ) {
                            showSnakBar(1, msg: 'Please Select Items First!');
                          }else if(controller.hasKotNoItem.isEmpty){

                            showSnakBar(1, msg: 'Please Generate kot of Items First!');

                          }
                          else {
                            Get.to(() => PaymentScreen(
                                      stOrderSummary: controller
                                          .addedItemData!.orderSummary,
                                      orderId: controller.items.first.orderId,
                                      tableId: widget.stTableId,
                                    ))!
                                .then((value) {
                              controller.getAllAddedItem();
                            });
                          }
                        },
                        stBackColor: AppColors.blackColor,
                        stTitleColor: AppColors.whiteColor,
                        stFontWeight: FontWeight.w500,
                        stFontSize: 18,
                      ))
                    : const SizedBox(),
                tableController.userProfileData!.data!.user!.type == 2
                    ? const SizedBox(
                        height: 2,
                      )
                    : const SizedBox(),
              ],
            );
          }),
    );
  }

  /// Tab Bar View
  Widget tabBarView() {
    return Expanded(
      child: TabBarView(
        controller: controller.tabController,
        children: [
          /// All Items View
          allItemView(),

          /// Added Item View
          addedItemView()
        ],
      ),
    );
  }

  /// All Item View
  Widget allItemView() {
    return GetBuilder<OrderController>(
        id: 'isLoadingAllItem',
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.themeColor,
                ))
              : Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: CustomAppbarTextfield(
                          controller: controller.stSearchBar,
                          onSearch: (query) {
                            controller.getAllItem(stQuery: query);
                          },
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          itemCount: controller.items.length,
                          itemBuilder: (context, index) {
                            Datum data = controller.items[index];
                            return menuItemView(data, index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  /// Menu Item View
  Widget menuItemView(Datum data, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          /*decoration: BoxDecoration(
            color: AppColors.themeColor.withOpacity(0.7),
          ),*/
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 12),
          child: Row(
            children: [
              CustomText(
                data.name,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 21,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5),
                  child: Divider(
                    color: AppColors.blackColor, // Line color
                    thickness: 1, // Line thickness
                  ),
                ),
              ),
            ],
          ),
        ),
        if (data.items.isNotEmpty)
          Container(
            height: 149,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.items.length,
              itemBuilder: (context, itemIndex) {
                Item item = data.items[itemIndex];
                return GetBuilder<OrderController>(
                    id: 'orderitem',
                    builder: (controller) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              margin: const EdgeInsets.only(left: 5, top: 4),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(50),
                                    offset: const Offset(6, 5),
                                    blurRadius: 9,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 28,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              "₹ ${item.salerate}",
                                              fontSize: 13,
                                            ),
                                          ),
                                          if (item.itemQty! > 0)
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.only(
                                                    right: 5,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5, left: 5),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.themeColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: CustomText(
                                                    item.itemQty!.toString(),
                                                    color:
                                                        AppColors.blackColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.addItemInOrder(item, index);
                                    },
                                    child: Container(
                                      height: 75,
                                      width: Get.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          // Adjust the radius as needed
                                          child: Image.network(
                                            item.image ?? '',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 22,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: CustomText(
                                          item.name,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (item.itemQty! > 0) // Show badge if quantity > 0
                            Positioned(
                              top: 41,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.hintTextColor
                                          .withOpacity(0.2),
                                      offset: const Offset(0, 4),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: Container(
                                  height: 80,
                                  width: 40,
                                  margin: const EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.showDynamicDialog(
                                              context,
                                              AppStrings.Notes,
                                              "",
                                              CustomTextFiled(
                                                stTitle: AppStrings.Notes,
                                                controller:
                                                    controller.stDiscountType,
                                                hintText: AppStrings.Notes,
                                                isRequired: true,
                                                keyboardType:
                                                    TextInputType.name,
                                              ),
                                              "Cancel",
                                              "Save",
                                              () {
                                                controller.addItemInOrder(
                                                    item, index,
                                                    stRemark: controller
                                                        .stDiscountType.text);
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: AppColors.blackColor,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            /* item['quantity'] -= 1;
                                            controller.update([
                                              'orderitem',
                                              'totalQuantity'
                                            ]); // Update UI*/
                                            controller.removeItemInOrder(
                                                item, index);
                                          },
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            color: AppColors.blackColor,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    });
              },
            ),
          ),
      ],
    );
  }

  /// Added Item View
  Widget addedItemView() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    AppStrings.addedItem,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  controller.orderItem.isNotEmpty ||
                          controller.hasKotNoItem.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            controller.showDynamicDialog(
                              context,
                              'Delete All',
                              "Are you sure you want to delete all items for this order?",
                              SizedBox(),
                              "No",
                              "Yes",
                              () {
                                controller.clearTableItem();
                              },
                            );

                            /* Get.to(
                        () => const BillScreen(),
                      );*/
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CustomText(
                              AppStrings.clearTable,
                              fontSize: 12,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            /* controller.hasKotNoItem.isEmpty ? SizedBox() :
            Expanded(
              child: Container(
                child: Align(
                  alignment: controller.hasKotNoItem.isEmpty ? Alignment.center : Alignment.topCenter ,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.center ,
                      children: [
                        GetBuilder<OrderController>(
                          id: 'isLoadingAddedItem',
                          builder: (context) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.hasKotNoItem.length,
                              itemBuilder: (context, index) {
                                HasKotNo item = controller.hasKotNoItem[index];
                                return Container(
                                  width: Get.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 7),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.transparentColor,
                                    border: index != controller.hasKotNoItem.length - 1
                                        ? Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300, width: 1.0),
                                    )
                                        : null,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                      color: Colors.red.withOpacity(0.1),
                                                    ),
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.redAccent,
                                                      size: 19,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 4, left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      CustomText(
                                                        'Kot No',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      CustomText(
                                                        '(₹ ${item.totalAmount})',
                                                        fontSize: 12,
                                                        color: AppColors.hintTextColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: CustomText(
                                                    '₹ ${item.totalAmount}',
                                                    color: Colors.green,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),*/
            Expanded(
                child: Container(
              child: Align(
                alignment: controller.orderItem.isEmpty &&
                        controller.hasKotNoItem.isEmpty
                    ? Alignment.center
                    : Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.hasKotNoItem.isEmpty
                          ? SizedBox()
                          : GetBuilder<OrderController>(
                              id: 'isLoadingAddedItem',
                              builder: (context) {
                                return Scrollbar(
                                  thickness: 5,
                                  // Width of scrollbar
                                  radius: Radius.circular(10),
                                  // Rounded edges for scrollbar
                                  thumbVisibility: true,
                                  // Always show scrollbar thumb
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.hasKotNoItem.length,
                                    itemBuilder: (context, index) {
                                      HasKotNo item =
                                          controller.hasKotNoItem[index];
                                      return Container(
                                        width: Get.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: AppColors.transparentColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .greyBackGroundColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 8),
                                                      child: SizedBox(
                                                        height: 100,
                                                        width: 50,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8)),
                                                          child: Image.network(
                                                              fit: BoxFit.cover,
                                                              item.kotImage!),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              CustomText(
                                                                'Kot No : ${item.kotNo}',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              CustomText(
                                                                'Total  Items : ${item.totalQuantity}',
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .hintTextColor,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                CustomText(
                                                                  '₹ ${item.totalAmount}',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ),
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      controller
                                                                          .showDynamicDialog(
                                                                        context,
                                                                        'Item For Kot No : ${controller.hasKotNoItem[index].kotNo}',
                                                                        "",
                                                                        LayoutBuilder(builder:
                                                                            (context,
                                                                                constraints) {
                                                                          return Container(
                                                                            constraints:
                                                                                BoxConstraints(
                                                                              maxHeight: Get.height * 0.5,
                                                                              minHeight: Get.height * 0.2,
                                                                            ),
                                                                            child: (index < controller.hasKotNoItem.length && controller.hasKotNoItem[index].items != null && controller.hasKotNoItem[index].items.isNotEmpty)
                                                                                ? Scrollbar(
                                                                                    controller: _scrollController,
                                                                                    // Provide the ScrollController
                                                                                    thickness: 5,
                                                                                    // Scrollbar thickness
                                                                                    radius: const Radius.circular(10),
                                                                                    // Rounded scrollbar
                                                                                    thumbVisibility: true,
                                                                                    // Show scrollbar always
                                                                                    child: ListView.builder(
                                                                                      controller: _scrollController,
                                                                                      shrinkWrap: true,
                                                                                      physics: const AlwaysScrollableScrollPhysics(),
                                                                                      // Allows scrolling
                                                                                      itemCount: controller.hasKotNoItem[index].items.length,
                                                                                      itemBuilder: (context, itemIndex) {
                                                                                        var item = controller.hasKotNoItem[index].items[itemIndex];
                                                                                        return Container(
                                                                                          margin: EdgeInsets.only(bottom: 5),
                                                                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                flex: 4,
                                                                                                child: ClipRRect(
                                                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                                  child: Container(
                                                                                                      height: 70,
                                                                                                      child: Image.network(
                                                                                                        item.itemImage ?? '',
                                                                                                        fit: BoxFit.cover,
                                                                                                      )),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 6,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                                  child: Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          CustomText(item.itemName ?? '', fontSize: 14),
                                                                                                          GestureDetector(
                                                                                                              onTap: () {
                                                                                                                controller.showDynamicDialog(
                                                                                                                  context,
                                                                                                                  'Delete',
                                                                                                                  'Are you sure you want to delete this item?',
                                                                                                                  SizedBox(),
                                                                                                                  "No",
                                                                                                                  "Yes",
                                                                                                                  () {
                                                                                                                    controller.removeItemFromKot(item, index);
                                                                                                                  },
                                                                                                                );
                                                                                                              },
                                                                                                              child: Icon(Icons.delete_outline_rounded, color: Colors.red, size: 17)),
                                                                                                        ],
                                                                                                      ),
                                                                                                      const SizedBox(height: 5),
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          CustomText('₹${item.itemPrice ?? ''}', fontSize: 16, fontWeight: FontWeight.w500),
                                                                                                          CustomText('Qty: ${item.quantity ?? ''}', fontSize: 15, fontWeight: FontWeight.w400),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  )
                                                                                : SizedBox(), // If no items, show an empty widget
                                                                          );
                                                                        }),
                                                                        "Cancel",
                                                                        "Print Kot",
                                                                        () {},
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .remove_red_eye_outlined)),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                      GetBuilder<OrderController>(
                        id: 'isLoadingAddedItem',
                        builder: (context) {
                          if (controller.isAddedItemLoading) {
                            // Show a loading indicator when fetching data
                            return Container(
                              child: CircularProgressIndicator(
                                color: AppColors.themeColor,
                              ),
                            );
                          }

                          if (controller.orderItem.isEmpty &&
                              controller.hasKotNoItem.isEmpty) {
                            return Container(
                              child: CustomText(AppStrings.noItemFound),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.orderItem.length,
                            itemBuilder: (context, index) {
                              Order item = controller.orderItem[index];
                              return Container(
                                width: Get.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.transparentColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.greyBackGroundColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                              child: SizedBox(
                                                height: 100,
                                                width: 50,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8)),
                                                  child: Image.network(
                                                      fit: BoxFit.cover,
                                                      item.itemImage!),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        item.itemName,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      CustomText(
                                                        '(₹ ${item.singleItemPrice})',
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .hintTextColor,
                                                      ),
                                                    ],
                                                  ),
                                                  if (item.remark!.isNotEmpty && item.remark != null)
                                                    CustomText(
                                                      '${item.remark}',
                                                      fontSize: 12,
                                                      color: AppColors
                                                          .blackColor
                                                          .withOpacity(0.7),
                                                    ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomText(
                                                          '₹ ${item.itemPrice}',
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                        Row(
                                                          children: [
                                                            if (item.quantity! >
                                                                1)
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .removeItemInAddedMinusOrder(
                                                                          item,
                                                                          index);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          1),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                              5),
                                                                    ),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 25,
                                                                    color: AppColors
                                                                        .themeColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8),
                                                              child: CustomText(
                                                                item.quantity
                                                                    .toString(),
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller
                                                                    .addItemInAddedPlusOrder(
                                                                        item,
                                                                        index);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(1),
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                ),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 25,
                                                                  color: AppColors
                                                                      .themeColor,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
