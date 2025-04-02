import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/api_call.dart';
import '../../../api/api_constant.dart';
import '../../../api/apis.dart';
import '../../../widget/custom_model.dart';
import '../../profile/model/user_profile_response_model.dart';
import '../model/all_item_response_model.dart';
import '../model/all_ordered_item_response_model.dart';
import '../model/item_add_response_model.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  num? stTableId;
  num? stIsEmptyId;

  OrderController({this.stTableId, this.stIsEmptyId});

  TextEditingController stDiscountType = TextEditingController();
  TextEditingController stDiscount = TextEditingController();
  TextEditingController stSearchBar = TextEditingController();

  bool isSearching = false;
  bool isLoading = true;

  String? selectedOption;

  bool isAddedItemLoading = true;

  late TabController tabController;
  num selectedIndex = 0; // Observable index

  OrderedItemModel? addedItemData;
  AllItemModel? allItemData;
  UserProfileModel? userProfileData;
  List<Datum> items = [];
  List<Order> orderItem = [];
  List<HasKotNo> hasKotNoItem = [];

  /// Get All Items
  getAllItem({String? stQuery}) async {
    Map<String, dynamic> params = {ApiConstant.tableId: stTableId, ApiConstant.q: stQuery != null ? stQuery :'' };
    // showLoader();
    var response = await ApiCall.getApiCall(
        endPoint: Apis.categoryList, isLoader: false, params: params);
    if (response != null) {
      allItemData = AllItemModel.fromJson(response);
      items = allItemData!.data;
      isLoading = false;
      update(['isLoadingAllItem','totalQuantity', 'orderSummary']);
    } else {
      isLoading = false;
      update(['isLoadingAllItem', 'totalQuantity', 'orderSummary']);
    }
  }

  /// Get Added All Items
  getAllAddedItem() async {
    Map<String, dynamic> params = {ApiConstant.tableId: stTableId};
    // showLoader();
    var response = await ApiCall.getApiCall(
        endPoint: Apis.getItem, isLoader: false, params: params);
    if (response != null) {
      addedItemData = OrderedItemModel.fromJson(response);
      orderItem = addedItemData!.orders;
      hasKotNoItem = addedItemData!.hasKotNo;
      isAddedItemLoading = false;
      update(['isLoadingAddedItem', 'orderSummary',]);
    } else {
      isAddedItemLoading = false;
      update(['isLoadingAddedItem', 'orderSummary']);
    }
  }

  /// Add Item From All Item Screen
  addItemInOrder(Item stItem, int index, {String? stRemark}) async {
    num newQty = (stRemark != null) ? stItem.itemQty! : (stItem.itemQty ?? 0) + 1;

    Map<String, dynamic> data = {
      ApiConstant.itemId: stItem.id,
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
      ApiConstant.itemQty: newQty,
      ApiConstant.counterId: stItem.counter,
      ApiConstant.itemRemark: stRemark ?? '',
    };

   var response = await ApiCall.postApiCall(
        endPoint: Apis.addItem,
        params: data,
        isLoader: false,
        isFormData: true,
        isHeader: true);
    if (response != null) {
      ItemAddModel data = ItemAddModel.fromJson(response);

      if(stRemark == null){
      items.first.orderId = data.orderId;
      items[index].items.where((ele) => ele.id == stItem.id).first.itemQty = stItem.itemQty! + 1;

      // Parse values safely
      double salerate = double.tryParse(stItem.salerate ?? '0') ?? 0;
      double gstper = double.tryParse(stItem.gst ?? '0') ?? 0;

      // **Fix: Proper GST Calculation**
      double totalSalerate = salerate * 1;
      double gstAmount = (gstper / 100) * totalSalerate;
      double totalAmount = totalSalerate + gstAmount;
      double totalTax = gstAmount;

      double currentNetAmount = double.tryParse(allItemData!.orderSummary!.netAmount ?? '0') ?? 0;
      double currentTaxAmount = double.tryParse(allItemData!.orderSummary!.totalTaxrate ?? '0') ?? 0;

      allItemData!.orderSummary!.netAmount = (currentNetAmount + totalAmount).toStringAsFixed(2);
      allItemData!.orderSummary!.totalTaxrate = (currentTaxAmount + totalTax).toStringAsFixed(2);

      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);
      }else{
        stDiscountType.clear();
        update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);
      }
    } else {
      return;
    }
  }

  /// Remove Item From All Item Screen
  removeItemInOrder(Item stItem, int index) async {
    Map<String, dynamic> data = {
      ApiConstant.itemId: stItem.id,
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
    };


    var response = await ApiCall.postApiCall(
        endPoint: Apis.removeItem,
        params: data,
        isLoader: false,
        isFormData: true,
        isHeader: true);
    if (response != null) {
      ItemAddModel data = ItemAddModel.fromJson(response);

      items[index].items.where((ele) => ele.id == stItem.id).first.itemQty =
          stItem.itemQty! - 1;

      // Parse values safely
      double salerate = double.tryParse(stItem.salerate ?? '0') ?? 0;
      double gstper = double.tryParse(stItem.gst ?? '0') ?? 0;

      // **Fix: Proper GST Calculation for Removal**
      double totalSalerate = salerate * 1;
      double gstAmount = (gstper / 100) * totalSalerate;
      double totalAmount = totalSalerate + gstAmount;
      double totalTax = gstAmount;


      // Reduce the removed item's value from netAmount and totalTaxrate
      double currentNetAmount = double.tryParse(allItemData!.orderSummary!.netAmount ?? '0') ?? 0;
      double currentTaxAmount = double.tryParse(allItemData!.orderSummary!.totalTaxrate ?? '0') ?? 0;

      allItemData!.orderSummary!.netAmount = (currentNetAmount - totalAmount).toStringAsFixed(2);
      allItemData!.orderSummary!.totalTaxrate = (currentTaxAmount - totalTax).toStringAsFixed(2);

      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);
    } else {
      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);
    }
  }

  /// Add Item From Added Item Screen
  addItemInAddedPlusOrder(Order stItem, int index,{String? stRemark}) async {
    num newQty = (stRemark != null) ? stItem.quantity! : (stItem.quantity ?? 0) + 1;

    Map<String, dynamic> data = {
      ApiConstant.itemId: stItem.itemId,
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
      ApiConstant.itemQty: newQty,
      ApiConstant.counterId: stItem.counterId,
      ApiConstant.itemRemark: stRemark ?? '',
    };

    var response = await ApiCall.postApiCall(
        endPoint: Apis.addItem,
        params: data,
        isLoader: false,
        isFormData: true,
        isHeader: true);
    if (response != null) {
      ItemAddModel data = ItemAddModel.fromJson(response);


       if(stRemark == null){

         items.where((datas) => datas.id.toString() == stItem.categoryId).first.items.where((map) => map.id == stItem.itemId).first.itemQty! + 1;

         orderItem.where((ele) => ele.itemId == stItem.itemId).first.quantity = stItem.quantity! + 1;

         orderItem.where((ele) => ele.itemId == stItem.itemId).first.itemPrice =
             (double.parse(stItem.singleItemPrice.toString()) * (newQty)).toStringAsFixed(2);

         // Parse values safely
         double salerate = double.tryParse(stItem.singleItemPrice ?? '0') ?? 0;
         double gstper = double.tryParse(stItem.igstper ?? '0') ?? 0;

         // **Fix: Proper GST Calculation**
         double totalSalerate = salerate * 1;
         double gstAmount = (gstper / 100) * totalSalerate;
         double totalAmount = totalSalerate + gstAmount;
         double totalTax = gstAmount;

         double currentNetAmount = double.tryParse(addedItemData!.orderSummary!.netAmount ?? '0') ?? 0;
         double currentSubAmount = double.tryParse(addedItemData!.orderSummary!.subTotal ?? '0') ?? 0;
         double currentTaxAmount = double.tryParse(addedItemData!.orderSummary!.totalTaxRate ?? '0') ?? 0;

         double currentAllItemsTaxAmount = double.tryParse(allItemData!.orderSummary!.totalTaxrate ?? '0') ?? 0;

         allItemData?.orderSummary?.netAmount = (currentNetAmount + totalAmount).toStringAsFixed(2);
         allItemData?.orderSummary?.totalTaxrate = (currentAllItemsTaxAmount + totalTax).toStringAsFixed(2);
         addedItemData!.orderSummary!.netAmount = (currentNetAmount + totalAmount).toStringAsFixed(2);
         addedItemData!.orderSummary!.totalTaxRate = (currentTaxAmount + totalTax).toStringAsFixed(2);
         addedItemData!.orderSummary!.subTotal = (currentSubAmount + salerate).toStringAsFixed(2);
         double subTotal = double.tryParse(addedItemData!.orderSummary!.subTotal ?? '0') ?? 0;
         double totalTaxRate = double.tryParse(addedItemData!.orderSummary!.totalTaxRate ?? '0') ?? 0;
         double discountPer = double.tryParse(addedItemData!.orderSummary!.discountPer ?? '0') ?? 0;

         double finalNetAmount = subTotal + totalTaxRate;
         double discountAmount = (finalNetAmount * discountPer) / 100;
         double netAmount = finalNetAmount - discountAmount; // Apply discount properly

         addedItemData!.orderSummary!.discountAmount =  discountAmount.toStringAsFixed(2);

         double netAmountValue = double.tryParse(netAmount.toStringAsFixed(2)) ?? 0.0;
         double roundedNetAmount = (netAmountValue - netAmountValue.floor() >= 0.50)
             ? netAmountValue.roundToDouble()  // Round up if >= 0.50
             : netAmountValue.floorToDouble(); // Round down if < 0.50

         addedItemData!.orderSummary!.netAmount = roundedNetAmount.toStringAsFixed(2);

         update(['isLoadingAddedItem', 'orderSummary']);
      }

    } else {}
  }

  /// Remove Item From Added Item Screen
  removeItemInAddedMinusOrder(Order stItem, int index) async {
    if (stItem.quantity == null || stItem.quantity! <= 0) return;

    num newQty = stItem.quantity! - 1;

    Map<String, dynamic> data = {
      ApiConstant.itemId: stItem.itemId,
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
      ApiConstant.itemQty: newQty,
      ApiConstant.counterId: stItem.counterId,
      ApiConstant.itemRemark: '',
    };

    if (stItem.quantity! > 1) {
      var response = await ApiCall.postApiCall(
          endPoint: Apis.addItem,
          params: data,
          isLoader: false,
          isFormData: true,
          isHeader: true);

      if (response != null) {
        var selectedItem = orderItem.firstWhere((ele) => ele.itemId == stItem.itemId);

        // Reduce quantity
        selectedItem.quantity = newQty;

        // Ensure price is parsed correctly
        double singlePrice = double.tryParse(stItem.singleItemPrice.toString()) ?? 0.0;
        double currentTotal = double.tryParse(selectedItem.itemPrice.toString()) ?? 0.0;
        selectedItem.itemPrice = (currentTotal - singlePrice).toStringAsFixed(2);

        double salerate = double.tryParse(stItem.singleItemPrice ?? '0') ?? 0;
        double gstper = double.tryParse(stItem.igstper ?? '0') ?? 0;

        // Proper GST Calculation for Removal
        double totalSalerate = salerate * 1;
        double gstAmount = (gstper / 100) * totalSalerate;
        double totalAmount = totalSalerate + gstAmount;
        double totalTax = gstAmount;

        // Reduce removed item's value from netAmount and totalTaxrate
        double currentNetAmount = double.tryParse(addedItemData!.orderSummary!.netAmount ?? '0') ?? 0;
        double currentTaxAmount = double.tryParse(addedItemData!.orderSummary!.totalTaxRate ?? '0') ?? 0;
        double currentSubAmount = double.tryParse(addedItemData!.orderSummary!.subTotal ?? '0') ?? 0;

        allItemData!.orderSummary!.netAmount = (currentNetAmount - totalAmount).toStringAsFixed(2);
        allItemData!.orderSummary!.totalTaxrate = (currentTaxAmount - totalTax).toStringAsFixed(2);
        addedItemData!.orderSummary!.netAmount = (currentNetAmount - totalAmount).toStringAsFixed(2);
        addedItemData!.orderSummary!.totalTaxRate = (currentTaxAmount - totalTax).toStringAsFixed(2);
        addedItemData!.orderSummary!.subTotal = (currentSubAmount - salerate).toStringAsFixed(2);

        // Recalculate final net amount after removing item
        double subTotal = double.tryParse(addedItemData!.orderSummary!.subTotal ?? '0') ?? 0;
        double totalTaxRate = double.tryParse(addedItemData!.orderSummary!.totalTaxRate ?? '0') ?? 0;
        double discountPer = double.tryParse(addedItemData!.orderSummary!.discountPer ?? '0') ?? 0;

        double finalNetAmount = subTotal + totalTaxRate;
        double discountAmount = (finalNetAmount * discountPer) / 100;
        double netAmount = finalNetAmount - discountAmount;

        addedItemData!.orderSummary!.discountAmount = discountAmount.toStringAsFixed(2);

        double netAmountValue = double.tryParse(netAmount.toStringAsFixed(2)) ?? 0.0;
        double roundedNetAmount = (netAmountValue - netAmountValue.floor() >= 0.50)
            ? netAmountValue.roundToDouble()
            : netAmountValue.floorToDouble();

        addedItemData!.orderSummary!.netAmount = roundedNetAmount.toStringAsFixed(2);

        update(['isLoadingAddedItem', 'orderSummary']);
      }
    }
  }

  /// Delete Single Item From Added Item Screen
  removeItemAddedInOrder(Order stItem, int index) async {

    Map<String, dynamic> data = {
      ApiConstant.itemId: stItem.itemId,
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
    };


    var response = await ApiCall.postApiCall(
        endPoint: Apis.removeItem,
        params: data,
        isLoader: false,
        isFormData: true,
        isHeader: true);

    if (response != null) {


      items.where((ele)=>ele.id.toString() == stItem.categoryId).first.items.where((data)=>data.id==stItem.itemId).first.itemQty = 0;
      orderItem.removeWhere((dict) => dict.itemId == stItem.itemId);

      ///---------------- Less Amount(Net Amount + Tax Amount) From Added Item Total Amount ------------------///
      // Safely extract netAmount
      double netAmount = double.tryParse(addedItemData?.orderSummary?.netAmount?.toString() ?? "0.0") ?? 0.0;

      double asalerate = double.tryParse(stItem.singleItemPrice ?? '0') ?? 0;
      double agstper = double.tryParse(stItem.igstper ?? '0') ?? 0;
      double quantity = double.tryParse(stItem.quantity.toString()) ?? 0.0;

      // **Fix: Proper GST Calculation**
      double atotalSalerate = asalerate * quantity;
      double agstAmount = (agstper / 100) * atotalSalerate;
      double totalAmount = atotalSalerate + agstAmount;

      netAmount -= totalAmount;


      addedItemData!.orderSummary!.netAmount = netAmount.toStringAsFixed(2);
      allItemData!.orderSummary!.netAmount = netAmount.toStringAsFixed(2);

      ///------------ Minus The Tax Amount From Added Item Tax --------------///

      // double netAmount = double.tryParse(addedItemData!.orderSummary!.netAmount ?? "0") ?? 0.0;
      double itemPrice = double.tryParse(stItem.itemPrice ?? "0") ?? 0.0;

      double salerate = double.tryParse(stItem.singleItemPrice ?? '0') ?? 0;
      double gstper = double.tryParse(stItem.igstper ?? '0') ?? 0;

      // **Fix: Proper GST Calculation**
      double totalSalerate = (salerate) * (stItem.quantity ?? 0);
      double gstAmount = (gstper / 100) * totalSalerate;
      double totalTax = gstAmount;

      // **Ensure totalTaxRate is parsed correctly before subtraction**
      double currentAddedTaxRate = double.tryParse(addedItemData!.orderSummary!.totalTaxRate ?? "0") ?? 0.0;
      double currentAllTaxRate = double.tryParse(allItemData!.orderSummary!.totalTaxrate ?? "0") ?? 0.0;

      double updatedAddedTaxRate = currentAddedTaxRate - totalTax;
      double updatedAllTaxRate = currentAllTaxRate - totalTax;

      addedItemData!.orderSummary!.totalTaxRate = updatedAddedTaxRate.toStringAsFixed(2);
      allItemData!.orderSummary!.totalTaxrate = updatedAllTaxRate.toStringAsFixed(2);

      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);

    } else {
      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);
    }
  }

  /// Delete All Item In Item Added Screen
  clearTableItem() async {

    Map<String, dynamic> data = {
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
    };

    var response = await ApiCall.postApiCall(
        endPoint: Apis.deleteAllItems,
        params: data,
        isLoader: false,
        isFormData: true,
        isHeader: true);

    if (response != null) {
      orderItem.clear();
      hasKotNoItem.clear();

      for (var data in items) {
        for(var element in data.items){
          element.itemQty = 0;
        }
      }

      addedItemData!.orderSummary!.discountPer = '0.0';
      addedItemData!.orderSummary!.discountAmount = '0.00';
      addedItemData!.orderSummary!.subTotal = '0.0';
      addedItemData!.orderSummary!.totalTaxRate = '0.0';
      addedItemData!.orderSummary!.netAmount = '0.0';
      allItemData!.orderSummary!.netAmount = '0.0';
      allItemData!.orderSummary!.totalTaxrate = '0.0';


      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);

    } else {
      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);
    }
  }

  /// Apply Discoubt In Added Item
  applyDiscountItem() async {

    Map<String, dynamic> data = {
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
      ApiConstant.discountType: selectedOption == 'Per%' ? 'percentage' : 'fixed',
      ApiConstant.discountInput: stDiscount.text,
    };

    var response = await ApiCall.postApiCall(
        endPoint: Apis.applyOrderDiscount,
        params: data,
        isLoader: false,
        isFormData: true,
        isHeader: true);

    if (response != null) {
      getAllAddedItem();

      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);

    } else {
      update(['totalQuantity', 'orderitem', 'orderSummary', 'isLoadingAddedItem']);
    }
  }

  /// Delete Item From Kot
  removeItemFromKot(Order stItem, int index) async {

    Map<String, dynamic> data = {
      ApiConstant.itemId: stItem.itemId,
      ApiConstant.orderId: items.first.orderId,
      ApiConstant.tableId: stTableId,
      ApiConstant.kotNo: stItem.kotNo,
    };

    var response = await ApiCall.postApiCall(
        endPoint: Apis.kotItemDelete,
        params: data,
        isLoader: false,
        isFormData: true,
        isHeader: true);

    if (response != null) {
      Get.back();
      getAllAddedItem();
    } else {
      Get.back();
    }
  }

  checkBackValue() {
    if (stIsEmptyId == 1) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].items.any((ele) => (ele.itemQty ?? 0) > 0)) {
          return true;
        }
      }
      return false;
    } else {
      for (int i = 0; i < items.length; i++) {
        if (items[i].items.any((ele) => (ele.itemQty ?? 0) != 0)) {
          return false;
        }
      }
      return true;
    }
  }

  isBackFunCall() {
    bool isValue = checkBackValue();
    Get.back(result: isValue);
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      selectedIndex = tabController.index;
      Future.delayed(Duration(milliseconds: 10),() {
        update(['orderSummary']);
      },);
      if (selectedIndex == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          getAllAddedItem();
        });
        update(['keyfilteredItems']);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllItem();
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
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
