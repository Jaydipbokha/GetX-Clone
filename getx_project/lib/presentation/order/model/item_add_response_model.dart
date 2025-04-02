class ItemAddModel {
  ItemAddModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.orderId,
  });

  final num? status;
  final num? statusCode;
  final String? msg;
  final num? orderId;

  factory ItemAddModel.fromJson(Map<String, dynamic> json){
    return ItemAddModel(
      status: json["status"],
      statusCode: json["status_code"],
      msg: json["msg"],
      orderId: json["order_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "msg": msg,
    "order_id": orderId,
  };

}
