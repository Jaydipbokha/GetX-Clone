class OrderedItemModel {
  OrderedItemModel({
    required this.success,
    required this.orders,
    required this.totalItem,
    required this.tableid,
    required this.hasKotNo,
    required this.ordertotal,
    required this.orderSummary,
  });

  final bool? success;
  final List<Order> orders;
  final num? totalItem;
  final bool? tableid;
  final List<HasKotNo> hasKotNo;
  final List<Ordertotal> ordertotal;
  OrderSummary? orderSummary;

  factory OrderedItemModel.fromJson(Map<String, dynamic> json){
    return OrderedItemModel(
      success: json["success"],
      orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      totalItem: json["total_item"],
      tableid: json["tableid"],
      hasKotNo: json["hasKotNo"] == null ? [] : List<HasKotNo>.from(json["hasKotNo"]!.map((x) => HasKotNo.fromJson(x))),
      ordertotal: json["ordertotal"] == null ? [] : List<Ordertotal>.from(json["ordertotal"]!.map((x) => Ordertotal.fromJson(x))),
      orderSummary: json["order_summary"] == null ? null : OrderSummary.fromJson(json["order_summary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "orders": orders.map((x) => x.toJson()).toList(),
    "total_item": totalItem,
    "tableid": tableid,
    "hasKotNo": hasKotNo.map((x) => x.toJson()).toList(),
    "ordertotal": ordertotal.map((x) => x.toJson()).toList(),
    "order_summary": orderSummary?.toJson(),
  };

}

class HasKotNo {
  HasKotNo({
    required this.totalAmount,
    required this.totalQuantity,
    required this.orderId,
    required this.tableid,
    required this.kotNo,
    required this.orderno,
    required this.kotImage,
    required this.items,
  });

  final String? totalAmount;
  final String? totalQuantity;
  final num? orderId;
  final num? tableid;
  final num? kotNo;
  final num? orderno;
  final String? kotImage;
  final List<Order> items;

  factory HasKotNo.fromJson(Map<String, dynamic> json){
    return HasKotNo(
      totalAmount: json["total_amount"],
      totalQuantity: json["total_quantity"],
      orderId: json["order_id"],
      tableid: json["tableid"],
      kotNo: json["kot_no"],
      orderno: json["orderno"],
      kotImage: json["kot_image"],
      items: json["items"] == null ? [] : List<Order>.from(json["items"]!.map((x) => Order.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "total_amount": totalAmount,
    "total_quantity": totalQuantity,
    "order_id": orderId,
    "tableid": tableid,
    "kot_no": kotNo,
    "orderno": orderno,
    "kot_image": kotImage,
    "items": items.map((x) => x.toJson()).toList(),
  };

}

class Order {
  Order({
    required this.itemId,
    required this.orderno,
    required this.itemName,
    required this.itemImage,
    required this.singleItemPrice,
    required this.categoryId,
    required this.itemPrice,
    required this.tableId,
    required this.counterId,
    required this.igstper,
    required this.igstrate,
    required this.sgstper,
    required this.cgstper,
    required this.sgstrate,
    required this.cgstrate,
    required this.roundUp,
    required this.quantity,
    required this.kotNo,
    required this.remark,
  });

  final num? itemId;
  final num? orderno;
  final String? itemName;
  final String? itemImage;
  final String? singleItemPrice;
  final String? categoryId;
   String? itemPrice;
  final num? tableId;
  final num? counterId;
  final String? igstper;
  final String? igstrate;
  final String? sgstper;
  final String? cgstper;
  final String? sgstrate;
  final String? cgstrate;
  final String? roundUp;
  num? quantity;
  final num? kotNo;
  final String? remark;

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      itemId: json["itemId"],
      orderno: json["orderno"],
      itemName: json["itemName"],
      itemImage: json["itemImage"],
      singleItemPrice: json["single_item_price"],
      categoryId: json["category_id"],
      itemPrice: json["itemPrice"],
      tableId: json["tableId"],
      counterId: json["counterId"],
      igstper: json["igstper"],
      igstrate: json["igstrate"],
      sgstper: json["sgstper"],
      cgstper: json["cgstper"],
      sgstrate: json["sgstrate"],
      cgstrate: json["cgstrate"],
      roundUp: json["RoundUp"],
      quantity: json["quantity"],
      kotNo: json["kot_no"],
      remark: json["remark"],
    );
  }

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "orderno": orderno,
    "itemName": itemName,
    "itemImage": itemImage,
    "single_item_price": singleItemPrice,
    "category_id": categoryId,
    "itemPrice": itemPrice,
    "tableId": tableId,
    "counterId": counterId,
    "igstper": igstper,
    "igstrate": igstrate,
    "sgstper": sgstper,
    "cgstper": cgstper,
    "sgstrate": sgstrate,
    "cgstrate": cgstrate,
    "RoundUp": roundUp,
    "quantity": quantity,
    "kot_no": kotNo,
    "remark": remark,
  };

}

class OrderSummary {
  OrderSummary({
    required this.netAmount,
    required this.subTotal,
    required this.totalTaxRate,
    required this.ordertotalrate,
    required this.discountPer,
    required this.discountAmount,
    required this.roundUp,
  });

   String? netAmount;
   String? subTotal;
   String? totalTaxRate;
  final String? ordertotalrate;
   String? discountPer;
   String? discountAmount;
  final String? roundUp;

  factory OrderSummary.fromJson(Map<String, dynamic> json){
    return OrderSummary(
      netAmount: json["NetAmount"],
      subTotal: json["sub_total"],
      totalTaxRate: json["TotalTaxRate"],
      ordertotalrate: json["Ordertotalrate"],
      discountPer: json["discountPer"],
      discountAmount: json["discountAmount"],
      roundUp: json["RoundUp"],
    );
  }

  Map<String, dynamic> toJson() => {
    "NetAmount": netAmount,
    "sub_total": subTotal,
    "TotalTaxRate": totalTaxRate,
    "Ordertotalrate": ordertotalrate,
    "discountPer": discountPer,
    "discountAmount": discountAmount,
    "RoundUp": roundUp,
  };

}

class Ordertotal {
  Ordertotal({
    required this.totalAmount,
    required this.totalQuantity,
    required this.tableid,
    required this.kotNo,
    required this.orderno,
  });

  final String? totalAmount;
  final num? totalQuantity;
  final num? tableid;
  final num? kotNo;
  final num? orderno;

  factory Ordertotal.fromJson(Map<String, dynamic> json){
    return Ordertotal(
      totalAmount: json["total_amount"],
      totalQuantity: json["total_quantity"],
      tableid: json["tableid"],
      kotNo: json["kot_no"],
      orderno: json["orderno"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total_amount": totalAmount,
    "total_quantity": totalQuantity,
    "tableid": tableid,
    "kot_no": kotNo,
    "orderno": orderno,
  };

}
