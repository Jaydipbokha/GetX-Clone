



class TableModel {
  TableModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.data,
  });

  final num? status;
  final num? statusCode;
  final String? msg;
  final List<Datum> data;

  factory TableModel.fromJson(Map<String, dynamic> json){
    return TableModel(
      status: json["status"],
      statusCode: json["status_code"],
      msg: json["msg"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "msg": msg,
    "data": data.map((x) => x.toJson()).toList(),
  };

}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.isEmpty,
  });

  final num? id;
  final String? name;
  final String? code;
  final num? status;
  final num? isEmpty;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      status: json["status"],
      isEmpty: json["is_empty"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "status": status,
    "is_empty": isEmpty,
  };

}
