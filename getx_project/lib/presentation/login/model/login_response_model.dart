

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.tokenType,
    required this.token,
  });

  final num? status;
  final num? statusCode;
  final String? msg;
  final String? tokenType;
  final String? token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json){
    return LoginResponseModel(
      status: json["status"],
      statusCode: json["status_code"],
      msg: json["msg"],
      tokenType: json["token_type"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "msg": msg,
    "token_type": tokenType,
    "token": token,
  };

}
