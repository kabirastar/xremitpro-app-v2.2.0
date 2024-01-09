import 'dart:convert';

BeneficiariesListModel beneficiariesListModelFromJson(String str) =>
    BeneficiariesListModel.fromJson(json.decode(str));

String beneficiariesListModelToJson(BeneficiariesListModel data) =>
    json.encode(data.toJson());

class BeneficiariesListModel {
  final Message message;
  final BeneficiariesListModelData data;
  final String type;

  BeneficiariesListModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory BeneficiariesListModel.fromJson(Map<String, dynamic> json) =>
      BeneficiariesListModel(
        message: Message.fromJson(json["message"]),
        data: BeneficiariesListModelData.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class BeneficiariesListModelData {
  final List<Beneficiary> beneficiaries;
  final TemporaryData temporaryData;

  BeneficiariesListModelData({
    required this.beneficiaries,
    required this.temporaryData,
  });

  factory BeneficiariesListModelData.fromJson(Map<String, dynamic> json) =>
      BeneficiariesListModelData(
        beneficiaries: List<Beneficiary>.from(
            json["beneficiaries"].map((x) => Beneficiary.fromJson(x))),
        temporaryData: TemporaryData.fromJson(json["temporary_data"]),
      );

  Map<String, dynamic> toJson() => {
        "beneficiaries":
            List<dynamic>.from(beneficiaries.map((x) => x.toJson())),
        "temporary_data": temporaryData.toJson(),
      };
}

class Beneficiary {
  final int id;
  final int userId;
  final String firstName;
  final String middleName;
  final String lastName;
  final dynamic email;
  final dynamic country;
  final String city;
  final dynamic state;
  final String zipCode;
  final String phone;
  final String method;
  final dynamic mobileName;
  final dynamic accountNumber;
  final dynamic bankName;
  final dynamic ibanNumber;
  final dynamic address;
  final String documentType;
  final dynamic frontImage;
  final dynamic backImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Beneficiary({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    this.email,
    this.country,
    required this.city,
    this.state,
    required this.zipCode,
    required this.phone,
    required this.method,
    required this.mobileName,
    required this.accountNumber,
    this.bankName,
    this.ibanNumber,
    this.address,
    required this.documentType,
    this.frontImage,
    this.backImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"] ?? '',
        middleName: json["middle_name"] ?? '',
        lastName: json["last_name"] ?? '',
        email: json["email"] ?? '',
        country: json["country"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        zipCode: json["zip_code"] ?? '',
        phone: json["phone"] ?? '',
        method: json["method"] ?? '',
        mobileName: json["mobile_name"] ?? "",
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
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class TemporaryData {
  final String identifier;

  TemporaryData({
    required this.identifier,
  });

  factory TemporaryData.fromJson(Map<String, dynamic> json) => TemporaryData(
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
      };
}

class Message {
  final List<String> success;

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
