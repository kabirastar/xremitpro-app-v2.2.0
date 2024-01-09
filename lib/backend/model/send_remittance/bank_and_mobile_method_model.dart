import 'dart:convert';

BanksAndMobileMethodModel banksAndMobileMethodModelFromJson(String str) =>
    BanksAndMobileMethodModel.fromJson(json.decode(str));

String banksAndMobileMethodModelToJson(BanksAndMobileMethodModel data) =>
    json.encode(data.toJson());

class BanksAndMobileMethodModel {
  Message message;
  Data data;

  BanksAndMobileMethodModel({
    required this.message,
    required this.data,
  });

  factory BanksAndMobileMethodModel.fromJson(Map<String, dynamic> json) =>
      BanksAndMobileMethodModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  List<Bank> banks;
  List<Bank> mobileMethod;

  Data({
    required this.banks,
    required this.mobileMethod,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
        mobileMethod:
            List<Bank>.from(json["mobile_method"].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
        "mobile_method":
            List<dynamic>.from(mobileMethod.map((x) => x.toJson())),
      };
}

class Bank {
  int id;
  String name;
  String slug;
  String country;
  int status;

  Bank({
    required this.id,
    required this.name,
    required this.slug,
    required this.country,
    required this.status,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        country: json["country"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "country": country,
        "status": status,
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
