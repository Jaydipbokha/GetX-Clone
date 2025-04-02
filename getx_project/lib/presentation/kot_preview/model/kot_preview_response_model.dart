class KotPreviewModel {
  KotPreviewModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.data,
  });

  final num? status;
  final num? statusCode;
  final String? msg;
  final Data? data;

  factory KotPreviewModel.fromJson(Map<String, dynamic> json){
    return KotPreviewModel(
      status: json["status"],
      statusCode: json["status_code"],
      msg: json["msg"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "msg": msg,
    "data": data?.toJson(),
  };

}

class Data {
  Data({
    required this.success,
    required this.tablename,
    required this.orderNo,
    required this.orderId,
    required this.date,
    required this.customerName,
    required this.entryBy,
    required this.mobile,
    required this.items,
    required this.subtotal,
    required this.cgst,
    required this.sgst,
    required this.discount,
    required this.round,
    required this.total,
    required this.itemId,
    required this.kotNo,
    required this.fullDate,
  });

  final bool? success;
  final String? tablename;
  final String? orderNo;
  final num? orderId;
  final String? date;
  final String? customerName;
  final String? entryBy;
  final String? mobile;
  final List<Item> items;
  final String? subtotal;
  final String? cgst;
  final String? sgst;
  final String? discount;
  final String? round;
  final String? total;
  final num? itemId;
  final dynamic kotNo;
  final String? fullDate;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      success: json["success"],
      tablename: json["tablename"],
      orderNo: json["order_no"],
      orderId: json["order_id"],
      date: json["date"],
      customerName: json["customer_name"],
      entryBy: json["entry_by"],
      mobile: json["mobile"],
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      subtotal: json["subtotal"],
      cgst: json["cgst"],
      sgst: json["sgst"],
      discount: json["discount"],
      round: json["round"],
      total: json["total"],
      itemId: json["itemId"],
      kotNo: json["kot_no"],
      fullDate: json["full_date"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "tablename": tablename,
    "order_no": orderNo,
    "order_id": orderId,
    "date": date,
    "customer_name": customerName,
    "entry_by": entryBy,
    "mobile": mobile,
    "items": items.map((x) => x?.toJson()).toList(),
    "subtotal": subtotal,
    "cgst": cgst,
    "sgst": sgst,
    "discount": discount,
    "round": round,
    "total": total,
    "itemId": itemId,
    "kot_no": kotNo,
    "full_date": fullDate,
  };

}

class Item {
  Item({
    required this.name,
    required this.quantity,
    required this.amount,
    required this.remark,
  });

  final String? name;
  final num? quantity;
  final String? amount;
  final String? remark;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      name: json["name"],
      quantity: json["quantity"],
      amount: json["amount"],
      remark: json["remark"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "amount": amount,
    "remark": remark,
  };

}
