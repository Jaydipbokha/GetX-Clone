class AllItemModel {
  AllItemModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.data,
    required this.orderSummary,
  });

  final num? status;
  final num? statusCode;
  final String? msg;
  final List<Datum> data;
  final OrderSummary? orderSummary;

  factory AllItemModel.fromJson(Map<String, dynamic> json){
    return AllItemModel(
      status: json["status"],
      statusCode: json["status_code"],
      msg: json["msg"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      orderSummary: json["order_summary"] == null ? null : OrderSummary.fromJson(json["order_summary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "msg": msg,
    "data": data.map((x) => x.toJson()).toList(),
    "order_summary": orderSummary?.toJson(),
  };

}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.image,
    required this.orderId,
    required this.items,
  });

  final num? id;
  final String? name;
  final String? code;
  final num? status;
  final String? image;
  num? orderId;
  final List<Item> items;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      status: json["status"],
      image: json["image"],
      orderId: json["order_id"],
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "status": status,
    "image": image,
    "order_id": orderId,
    "items": items.map((x) => x.toJson()).toList(),
  };

}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.code,
    required this.category,
    required this.counter,
    required this.status,
    required this.salerate,
    required this.gst,
    required this.image,
    required this.categoryName,
    required this.itemQty,
  });

  final num? id;
  final String? name;
  final String? code;
  final String? category;
  final String? counter;
  final num? status;
  final String? salerate;
  final String? gst;
  final String? image;
  final String? categoryName;
  num? itemQty;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      category: json["category"],
      counter: json["counter"],
      status: json["status"],
      salerate: json["salerate"],
      gst: json["gst"],
      image: json["image"],
      categoryName: json["category_name"],
      itemQty: json["item_qty"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "category": category,
    "counter": counter,
    "status": status,
    "salerate": salerate,
    "gst": gst,
    "image": image,
    "category_name": categoryName,
    "item_qty": itemQty,
  };

}

class OrderSummary {
  OrderSummary({
    required this.netAmount,
    required this.subTotal,
    required this.totalTaxrate,
    required this.orderTotalRate,
    required this.discountPer,
    required this.discountAmount,
    required this.roundupAmount,
  });

  String? netAmount;
  final String? subTotal;
  String? totalTaxrate;
  final String? orderTotalRate;
  final String? discountPer;
  final String? discountAmount;
  final String? roundupAmount;

  factory OrderSummary.fromJson(Map<String, dynamic> json){
    return OrderSummary(
      netAmount: json["net_amount"],
      subTotal: json["sub_total"],
      totalTaxrate: json["total_taxrate"],
      orderTotalRate: json["order_total_rate"],
      discountPer: json["discount_per"],
      discountAmount: json["discount_amount"],
      roundupAmount: json["roundup_amount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "net_amount": netAmount,
    "sub_total": subTotal,
    "total_taxrate": totalTaxrate,
    "order_total_rate": orderTotalRate,
    "discount_per": discountPer,
    "discount_amount": discountAmount,
    "roundup_amount": roundupAmount,
  };

}
