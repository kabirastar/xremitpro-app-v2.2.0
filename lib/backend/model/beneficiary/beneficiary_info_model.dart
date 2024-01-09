import 'dart:convert';

BeneficiaryInfoModel beneficiaryInfoModelFromJson(String str) =>
    BeneficiaryInfoModel.fromJson(json.decode(str));

String beneficiaryInfoModelToJson(BeneficiaryInfoModel data) =>
    json.encode(data.toJson());

class BeneficiaryInfoModel {
  Message message;
  Data data;

  BeneficiaryInfoModel({
    required this.message,
    required this.data,
  });

  factory BeneficiaryInfoModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  List<Beneficiary> beneficiaries;

  Data({
    required this.beneficiaries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        beneficiaries: List<Beneficiary>.from(
            json["beneficiaries"].map((x) => Beneficiary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "beneficiaries":
            List<dynamic>.from(beneficiaries.map((x) => x.toJson())),
      };
}

class Beneficiary {
  int id;
  int userId;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic country;
  dynamic city;
  dynamic state;
  dynamic zipCode;
  dynamic phone;
  String method;
  dynamic mobileName;
  dynamic accountNumber;
  dynamic bankName;
  dynamic ibanNumber;
  String address;
  dynamic documentType;
  dynamic frontImage;
  dynamic backImage;
  DateTime createdAt;
  DateTime updatedAt;

  Beneficiary({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    this.country,
    required this.city,
    required this.state,
    required this.zipCode,
    this.phone,
    required this.method,
    this.mobileName,
    this.accountNumber,
    this.bankName,
    this.ibanNumber,
    required this.address,
    this.documentType,
    this.frontImage,
    this.backImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json["id"],
        userId: json["user_id"] ?? "",
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        country: json["country"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        zipCode: json["zip_code"] ?? '',
        phone: json["phone"] ?? '',
        method: json["method"],
        mobileName: json["mobile_name"] ?? '',
        accountNumber: json["account_number"] ?? '',
        bankName: json["bank_name"] ?? '',
        ibanNumber: json["iban_number"] ?? '',
        address: json["address"] ?? '',
        documentType: json["document_type"] ?? '',
        frontImage: json["front_image"] ?? '',
        backImage: json["back_image"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "country": country,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "phone": phone,
        "method": method,
        "mobile_name": mobileName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "iban_number": ibanNumber,
        "address": address,
        "document_type": documentType,
        "front_image": frontImage,
        "back_image": backImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
