import 'dart:convert';

SendingPurposeInfoModel sendingPurposeInfoModelFromJson(String str) =>
    SendingPurposeInfoModel.fromJson(json.decode(str));

String sendingPurposeInfoModelToJson(SendingPurposeInfoModel data) =>
    json.encode(data.toJson());

class SendingPurposeInfoModel {
  Message message;
  Data data;

  SendingPurposeInfoModel({
    required this.message,
    required this.data,
  });

  factory SendingPurposeInfoModel.fromJson(Map<String, dynamic> json) =>
      SendingPurposeInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  List<SendingPurpose> sendingPurposes;
  List<SendingPurpose> sourceOfFunds;
  List<PaymentGateway> paymentGateway;

  Data({
    required this.sendingPurposes,
    required this.sourceOfFunds,
    required this.paymentGateway,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sendingPurposes: List<SendingPurpose>.from(
            json["sending_purposes"].map((x) => SendingPurpose.fromJson(x))),
        sourceOfFunds: List<SendingPurpose>.from(
            json["source_of_funds"].map((x) => SendingPurpose.fromJson(x))),
        paymentGateway: List<PaymentGateway>.from(
            json["payment_gateway"].map((x) => PaymentGateway.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sending_purposes":
            List<dynamic>.from(sendingPurposes.map((x) => x.toJson())),
        "source_of_funds":
            List<dynamic>.from(sourceOfFunds.map((x) => x.toJson())),
        "payment_gateway":
            List<dynamic>.from(paymentGateway.map((x) => x.toJson())),
      };
}

class PaymentGateway {
  int id;
  int paymentGatewayId;
  String name;
  String alias;
  String currencyCode;
  String currencySymbol;
  dynamic image;
  String minLimit;
  String maxLimit;
  String percentCharge;
  String fixedCharge;
  String rate;
  DateTime createdAt;
  DateTime updatedAt;

  PaymentGateway({
    required this.id,
    required this.paymentGatewayId,
    required this.name,
    required this.alias,
    required this.currencyCode,
    required this.currencySymbol,
    required this.image,
    required this.minLimit,
    required this.maxLimit,
    required this.percentCharge,
    required this.fixedCharge,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
        id: json["id"],
        paymentGatewayId: json["payment_gateway_id"],
        name: json["name"],
        alias: json["alias"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
        image: json["image"],
        minLimit: json["min_limit"],
        maxLimit: json["max_limit"],
        percentCharge: json["percent_charge"],
        fixedCharge: json["fixed_charge"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_gateway_id": paymentGatewayId,
        "name": name,
        "alias": alias,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
        "image": image,
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "percent_charge": percentCharge,
        "fixed_charge": fixedCharge,
        "rate": rate,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class SendingPurpose {
  int id;
  String name;
  String slug;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  SendingPurpose({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SendingPurpose.fromJson(Map<String, dynamic> json) => SendingPurpose(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
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
