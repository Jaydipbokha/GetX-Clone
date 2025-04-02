class BillPreviewModel {
  BillPreviewModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.data,
  });

  final num? status;
  final num? statusCode;
  final String? msg;
   Data? data;

  factory BillPreviewModel.fromJson(Map<String, dynamic> json){
    return BillPreviewModel(
      status: json["status"],
      statusCode: json["status_code"],
      msg: json["msg"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.tablename,
    required this.orderNo,
    required this.orderId,
    required this.date,
    required this.customerName,
    required this.mobile,
    required this.items,
    required this.subtotal,
    required this.cgst,
    required this.sgst,
    required this.discount,
    required this.discountPer,
    required this.round,
    required this.total,
    required this.itemId,
    required this.kotNo,
    required this.fullDate,
  });

  final String? tablename;
  final String? orderNo;
  final num? orderId;
  final String? date;
  final String? customerName;
  final String? mobile;
  final List<Item> items;
  final String? subtotal;
  final String? cgst;
  final String? sgst;
  final String? discount;
  final String? discountPer;
  final String? round;
  final String? total;
  final num? itemId;
  final num? kotNo;
  final String? fullDate;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      tablename: json["tablename"],
      orderNo: json["order_no"],
      orderId: json["order_id"],
      date: json["date"],
      customerName: json["customer_name"],
      mobile: json["mobile"],
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      subtotal: json["subtotal"],
      cgst: json["cgst"],
      sgst: json["sgst"],
      discount: json["discount"],
      discountPer: json["discount_per"],
      round: json["round"],
      total: json["total"],
      itemId: json["itemId"],
      kotNo: json["kot_no"],
      fullDate: json["full_date"],
    );
  }

}

class Item {
  Item({
    required this.itemid,
    required this.name,
    required this.quantity,
    required this.amount,
    required this.remark,
    required this.image,
  });

  final num? itemid;
  final String? name;
  final num? quantity;
  final num? amount;
  final String? remark;
  final String? image;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      itemid: json["itemid"],
      name: json["name"],
      quantity: json["quantity"],
      amount: json["amount"],
      remark: json["remark"],
      image: json["image"],
    );
  }

}
