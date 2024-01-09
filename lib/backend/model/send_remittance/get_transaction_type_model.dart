import 'dart:convert';

import 'package:xremitpro/widgets/drop_down/drop_down.dart';

GetTransactionTypeModel getTransactionTypeModelFromJson(String str) =>
    GetTransactionTypeModel.fromJson(json.decode(str));

String getTransactionTypeModelToJson(GetTransactionTypeModel data) =>
    json.encode(data.toJson());

class GetTransactionTypeModel {
  final Message message;
  final Data data;

  GetTransactionTypeModel({
    required this.message,
    required this.data,
  });

  factory GetTransactionTypeModel.fromJson(Map<String, dynamic> json) =>
      GetTransactionTypeModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final List<ErCurrency> senderCurrency;
  final List<ErCurrency> receiverCurrency;
  final ImagePaths imagePaths;
  final List<TransactionType> transactionType;

  Data({
    required this.senderCurrency,
    required this.receiverCurrency,
    required this.imagePaths,
    required this.transactionType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        senderCurrency: List<ErCurrency>.from(
            json["sender_currency"].map((x) => ErCurrency.fromJson(x))),
        receiverCurrency: List<ErCurrency>.from(
            json["receiver_currency"].map((x) => ErCurrency.fromJson(x))),
        imagePaths: ImagePaths.fromJson(json["image_paths"]),
        transactionType: List<TransactionType>.from(
            json["transaction_type"].map((x) => TransactionType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sender_currency":
            List<dynamic>.from(senderCurrency.map((x) => x.toJson())),
        "receiver_currency":
            List<dynamic>.from(receiverCurrency.map((x) => x.toJson())),
        "image_paths": imagePaths.toJson(),
        "transaction_type":
            List<dynamic>.from(transactionType.map((x) => x.toJson())),
      };
}

class ImagePaths {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  ImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
        baseUrl: json["base_url"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "path_location": pathLocation,
        "default_image": defaultImage,
      };
}

class ErCurrency implements DropdownModel {
  final int id;
  final String country;
  final String name;
  final String code;
  final String symbol;
  final String type;
  final dynamic flag;
  final String rate;

  ErCurrency({
    required this.id,
    required this.country,
    required this.name,
    required this.code,
    required this.symbol,
    required this.type,
    this.flag,
    required this.rate,
  });

  factory ErCurrency.fromJson(Map<String, dynamic> json) => ErCurrency(
        id: json["id"],
        country: json["country"],
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
        type: json["type"],
        flag: json["flag"] ?? '',
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "name": name,
        "code": code,
        "symbol": symbol,
        "type": type,
        "flag": flag,
        "rate": rate,
      };

  @override
  String get img => flag;

  @override
  String get title => code;
}

class TransactionType {
  final int id;
  final String slug;
  final String title;
  final String fixedCharge;
  final String percentCharge;
  final String minLimit;
  final String maxLimit;
  final String featureText;

  TransactionType({
    required this.id,
    required this.slug,
    required this.title,
    required this.fixedCharge,
    required this.percentCharge,
    required this.minLimit,
    required this.maxLimit,
    required this.featureText,
  });

  factory TransactionType.fromJson(Map<String, dynamic> json) =>
      TransactionType(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        fixedCharge: json["fixed_charge"],
        percentCharge: json["percent_charge"],
        minLimit: json["min_limit"],
        maxLimit: json["max_limit"],
        featureText: json["feature_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "fixed_charge": fixedCharge,
        "percent_charge": percentCharge,
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "feature_text": featureText,
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
