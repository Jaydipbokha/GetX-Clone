class UserProfileModel {
  UserProfileModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.data,
  });

  final int? status;
  final int? statusCode;
  final String? msg;
  final Data? data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json){
    return UserProfileModel(
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
    required this.user,
  });

  final User? user;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
  };

}

class User {
  User({
    required this.id,
    required this.parentId,
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.hasEmail,
    required this.dialingCode,
    required this.phoneNumber,
    required this.mpin,
    required this.createdBy,
    required this.resetPasswordToken,
    required this.oneTimePassword,
    required this.isChangedPassword,
    required this.avatar,
    required this.signImage,
    required this.status,
    required this.subscriptionStatus,
    required this.referenceType,
    required this.referenceId,
    required this.houseNo,
    required this.addressLine1,
    required this.addressLine2,
    required this.area,
    required this.pincode,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.companyId,
    required this.lastActiveDateTime,
    required this.lastLoginDateTime,
    required this.privilege,
    required this.isSentMail,
    required this.fcmToken,
    required this.noOfDeal,
    required this.joiningDate,
    required this.mainContactId,
    required this.tag,
    required this.source,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.country,
    required this.state,
    required this.city,
  });

  final num? id;
  final num? parentId;
  final num? type;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic hasEmail;
  final String? dialingCode;
  final String? phoneNumber;
  final num? mpin;
  final num? createdBy;
  final dynamic resetPasswordToken;
  final String? oneTimePassword;
  final String? isChangedPassword;
  final String? avatar;
  final String? signImage;
  final num? status;
  final num? subscriptionStatus;
  final dynamic referenceType;
  final num? referenceId;
  final dynamic houseNo;
  final String? addressLine1;
  final String? addressLine2;
  final String? area;
  final String? pincode;
  final num? countryId;
  final num? stateId;
  final num? cityId;
  final num? companyId;
  final DateTime? lastActiveDateTime;
  final DateTime? lastLoginDateTime;
  final dynamic privilege;
  final num? isSentMail;
  final dynamic fcmToken;
  final num? noOfDeal;
  final String? joiningDate;
  final num? mainContactId;
  final dynamic tag;
  final String? source;
  final num? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final City? country;
  final City? state;
  final City? city;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      parentId: json["parent_id"],
      type: json["type"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      hasEmail: json["has_email"],
      dialingCode: json["dialing_code"],
      phoneNumber: json["phone_number"],
      mpin: json["mpin"],
      createdBy: json["created_by"],
      resetPasswordToken: json["reset_password_token"],
      oneTimePassword: json["one_time_password"],
      isChangedPassword: json["is_changed_password"],
      avatar: json["avatar"],
      signImage: json["sign_image"],
      status: json["status"],
      subscriptionStatus: json["subscription_status"],
      referenceType: json["reference_type"],
      referenceId: json["reference_id"],
      houseNo: json["house_no"],
      addressLine1: json["address_line1"],
      addressLine2: json["address_line2"],
      area: json["area"],
      pincode: json["pincode"],
      countryId: json["country_id"],
      stateId: json["state_id"],
      cityId: json["city_id"],
      companyId: json["company_id"],
      lastActiveDateTime: DateTime.tryParse(json["last_active_date_time"] ?? ""),
      lastLoginDateTime: DateTime.tryParse(json["last_login_date_time"] ?? ""),
      privilege: json["privilege"],
      isSentMail: json["is_sent_mail"],
      fcmToken: json["fcm_token"],
      noOfDeal: json["no_of_deal"],
      joiningDate: json["joining_date"],
      mainContactId: json["main_contact_id"],
      tag: json["tag"],
      source: json["source"],
      updatedBy: json["updated_by"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      country: json["country"] == null ? null : City.fromJson(json["country"]),
      state: json["state"] == null ? null : City.fromJson(json["state"]),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "type": type,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "has_email": hasEmail,
    "dialing_code": dialingCode,
    "phone_number": phoneNumber,
    "mpin": mpin,
    "created_by": createdBy,
    "reset_password_token": resetPasswordToken,
    "one_time_password": oneTimePassword,
    "is_changed_password": isChangedPassword,
    "avatar": avatar,
    "sign_image": signImage,
    "status": status,
    "subscription_status": subscriptionStatus,
    "reference_type": referenceType,
    "reference_id": referenceId,
    "house_no": houseNo,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "area": area,
    "pincode": pincode,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "company_id": companyId,
    "last_active_date_time": lastActiveDateTime?.toIso8601String(),
    "last_login_date_time": lastLoginDateTime?.toIso8601String(),
    "privilege": privilege,
    "is_sent_mail": isSentMail,
    "fcm_token": fcmToken,
    "no_of_deal": noOfDeal,
    "joining_date": joiningDate,
    "main_contact_id": mainContactId,
    "tag": tag,
    "source": source,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "country": country?.toJson(),
    "state": state?.toJson(),
    "city": city?.toJson(),
  };

}

class City {
  City({
    required this.id,
    required this.text,
  });

  final num? id;
  final String? text;

  factory City.fromJson(Map<String, dynamic> json){
    return City(
      id: json["id"],
      text: json["text"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
  };

}
